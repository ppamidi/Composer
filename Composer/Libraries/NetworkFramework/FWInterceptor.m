//
//  FWInterceptor.m
//  Framework
//
//  Created by Priyanka on 3/18/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWInterceptor.h"

@interface FWInterceptor ()
    @property (strong, nonatomic) NSArray *interceptors;
@end

@implementation FWInterceptor
@synthesize connection = _connection;

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
   
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

- (void)startLoading {
    self.connection = [[NSURLConnection alloc]initWithRequest:self.request delegate:self startImmediately:NO];
    [self.connection start];
}

- (void)stopLoading {
    [self.connection cancel];
}


#pragma mark - NSURLConnection delegates

// Forwarding delegate calls to AFNetworking handlers

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[self client] URLProtocol:self didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[self client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}



@end
