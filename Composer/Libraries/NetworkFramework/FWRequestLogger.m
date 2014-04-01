//
//  FWRequestLogger.m
//  Composer
//
//  Created by Prasad Pamidi on 3/31/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRequestLogger.h"
#import "FWConfiguration.h"
#import "RequestLog.h"
#import "FWRequestManager.h"
#import "FWImports.h"


@interface FWRequestLogger ()

@property (nonatomic) NSMutableDictionary *requestDetails;
@property (nonatomic) NSMutableData *responseData;

@end

@implementation FWRequestLogger
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    if ([FWConfiguration loggingEnabled]) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

- (void)startLoading {
    self.requestDetails = [[NSMutableDictionary alloc] init];
    self.responseData = [[NSMutableData alloc] init];
    
    [self startLogging];
}

- (void)stopLoading {
    [self.connection cancel];
}

- (void)startLogging {
    
    NSMutableURLRequest *customRequest = [[self request] mutableCopy];
    
    [self.requestDetails setObject:customRequest.URL forKey:@"RequestURL"];
    [self.requestDetails setObject:customRequest.HTTPMethod forKey:@"RequestMethod"];
    if (customRequest.allHTTPHeaderFields) {
        [self.requestDetails setObject:customRequest.allHTTPHeaderFields forKey:@"RequestHeaders"];
    }else{
        [self.requestDetails setObject:@"No request headers set" forKey:@"RequestHeaders"];
    }
    
    if (customRequest.HTTPBody) {
        [self.requestDetails setObject:[[NSString alloc] initWithData:customRequest.HTTPBody encoding:NSUTF8StringEncoding] forKey:@"RequestBody"];
    }else{
        [self.requestDetails setObject:@"No request body set" forKey:@"RequestBody"];
    }
    
     [self.requestDetails setObject:[NSDate date] forKey:@"RequestTime"];
    
    [[FWRequestManager requestManager] unRegisterInterceptor:self];
    self.connection = [[NSURLConnection alloc]initWithRequest:customRequest delegate:self startImmediately:NO];
    
    [self.connection start];
}

-(void) requestLoggingComplete:(NSMutableDictionary *) requestLog {
    FWDLog(@"Request Log Details %@", requestLog);
}

#pragma mark - NSURLConnection delegates

// Forwarding delegate calls to AFNetworking handlers

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
    [[super client] URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    FWDLog(@"%s", __PRETTY_FUNCTION__);
    [self.requestDetails setObject:[[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding] forKey:@"ResponseString"];
    [self requestLoggingComplete:_requestDetails];
    
    [[FWRequestManager requestManager] registerInterceptor:self];
    [[super client] URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.requestDetails setObject:[NSNumber numberWithInteger:200
                                    ] forKey:@"ResponseCode"];
    [self.requestDetails setObject:response.description forKey:@"ResponseHeaders"];
    [[super client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    FWDLog(@"%s", __PRETTY_FUNCTION__);
    [self.requestDetails setObject:[NSNumber numberWithInteger:error.code
                                    ] forKey:@"ResponseCode"];
    
    
    [self.requestDetails setObject:error.description forKey:@"ResponsHeaders"];
    
    FWDLog(@"%@ Request Log Details", self.requestDetails);
    [[super client] URLProtocol:self didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[super client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}
@end