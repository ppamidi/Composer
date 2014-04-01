//
//  FWEncyptionInterceptor.m
//  Framework
//
//  Created by Prasad Pamidi on 3/21/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWEncryptor.h"
#import "FWConfiguration.h"
#import "FWRequestManager.h"
#import "FWImports.h"
#import "FWEncryptionHelper.h"
#import "FWBase64Url.h"

@implementation FWEncryptor

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    if ([FWConfiguration encryptRequestParams]) {
        return YES;
    }
    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

- (void)startLoading {
   
    [self encryptRequestParams];
}

- (void)stopLoading {
    [self.connection cancel];
}

- (void)encryptRequestParams {
   
    NSMutableURLRequest *customRequest = [[self request] mutableCopy];
    
    NSMutableDictionary *requestBody = [[NSJSONSerialization JSONObjectWithData:customRequest.HTTPBody options:kNilOptions error:nil] mutableCopy];
    
    for (NSString *param in [requestBody allKeys]) {
        [requestBody setObject:[FWBase64Url encode:[FWEncryptionHelper encryptData:[[requestBody objectForKey:param] dataUsingEncoding:NSUTF8StringEncoding]]] forKey:param];
    }
    if (requestBody) {
      customRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestBody options:kNilOptions error:nil];
    }
  
    [[FWRequestManager requestManager] unRegisterInterceptor:self];
    self.connection = [[NSURLConnection alloc]initWithRequest:customRequest delegate:self startImmediately:NO];
    
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
