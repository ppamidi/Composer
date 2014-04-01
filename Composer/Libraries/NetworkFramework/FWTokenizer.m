//
//  FWSecureTokenInterceptor.m
//  Framework
//
//  Created by Priyanka on 3/18/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWTokenizer.h"
#import "FWConfiguration.h"
#import "FWSecureToken.h"
#import "FWRequestManager.h"
#import "FWImports.h"

@implementation FWTokenizer

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([FWConfiguration useSecureToken]) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    [self createConnectionWithSecureToken:nil];
}

- (void)stopLoading {
   [self.connection cancel];
}

- (void)secureServiceCall {
    FWSecureToken* secureToken = [NSKeyedUnarchiver unarchiveObjectWithFile:[FWDirectory filePathForSecureTokenData]];
    if (!secureToken) {
        [self getNewSecureToken];
    }else {
        NSComparisonResult result = [secureToken.expireTime compare:[NSDate date]];
        if (result == NSOrderedAscending || result == NSOrderedSame) {
            NSLog(@"Token Expired");
            [self getNewSecureToken];
        }else {
            [self createConnectionWithSecureToken:secureToken];
        }
    }
}

- (void)getNewSecureToken {
    [NSURLProtocol unregisterClass:[self class]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[FWConfiguration getGrantType],kGrantTypeKey,
                                [FWConfiguration getClientId],kClientIdKey,[FWConfiguration getClientSecret],
                                kClientSecretKey,[FWConfiguration getScope],kScopeKey,nil];
    [[FWRequestManager requestManager] setResponseContentType:RESPONSE_DEFAULT];
    [FWRequestManager buildRequestForPath:[FWConfiguration getSecureTokenURL] ofType:HTTPMethodPOST withParameters:parameters successHandler:^(NSString *responseString) {
        NSLog(@"Response for secure token = %@", responseString);
        FWSecureToken* secureToken = [[FWSecureToken alloc]init];
        [secureToken setAttributesFromResponse:responseString];
        [NSKeyedArchiver archiveRootObject:secureToken toFile:[FWDirectory filePathForSecureTokenData]];
        [self createConnectionWithSecureToken:secureToken];
    } errorHandler:^(NSError *error) {
        NSLog(@"%s %@",__PRETTY_FUNCTION__ ,error);
        [NSURLProtocol registerClass:[self class]];
    }];
}

- (void)createConnectionWithSecureToken:(FWSecureToken*)secureTokenData {
    NSMutableURLRequest *request = [[self request] mutableCopy];
    [request setAllHTTPHeaderFields:@{kAuthorization: @"CustomToken"}];
    
    [[FWRequestManager requestManager] unRegisterInterceptor:self];
    
    FWDLog(@"Request Headers %@", [request allHTTPHeaderFields]);
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [self.connection start];
}

#pragma mark - NSURLConnection delegates

// Forwarding delegate calls to AFNetworking handlers

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [[super client] URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    FWDLog(@"%s", __PRETTY_FUNCTION__);
    
    [[FWRequestManager requestManager] registerInterceptor:self];
    [[super client] URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[super client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    FWDLog(@"%s", __PRETTY_FUNCTION__);
    
    [[super client] URLProtocol:self didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[super client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

@end
