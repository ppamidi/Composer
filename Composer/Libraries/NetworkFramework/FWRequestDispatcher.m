//
//  FWHttpClient.m
//  Framework
//
//  Created by Priyanka on 3/17/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRequestDispatcher.h"
#import "FWConfiguration.h"

static NSString* const methods[] = {
    @"GET", @"POST", @"HEAD", @"PUT", @"DELETE"
};

@implementation FWRequestDispatcher

- (instancetype)initWithBaseURL:(NSURL *)url {
    NSLog(@"URL - %@",url);
    self = [super initWithBaseURL:url];
    
    return self;
}

// Create request
- (NSMutableURLRequest*)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    // URL encoding added for path
    NSError* error = nil;
    NSMutableURLRequest* request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&error];
    [request setTimeoutInterval:[FWConfiguration getTimeOutInterval]];
    
    return request;
}

// Construct request for HTTP Get
- (void)getResource:(NSString*)path withParameters:(NSDictionary *)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
              error:(FWHttpClientErrorHandler)errorHandler {
    NSMutableURLRequest* request = [self requestWithMethod:methods[HTTPMethodGET] path:path parameters:parameters];
    [self submitRequest:request successHandler:^(NSString *responseString) {
        successHandler(responseString);
    } error:^(NSError *error) {
        errorHandler(error);
    }];
}

// Construct request for HTTP Post
- (void)postResource:(NSString*)path withParameters:(NSDictionary *)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
               error:(FWHttpClientErrorHandler)errorHandler {
    NSMutableURLRequest* request = [self requestWithMethod:methods[HTTPMethodPOST] path:path parameters:parameters];
    [self submitRequest:request successHandler:^(NSString *responseString) {
        successHandler(responseString);
    } error:^(NSError *error) {
        errorHandler(error);
    }];
}

// Make service call to created request
- (void)submitRequest:(NSMutableURLRequest*)request successHandler:(FWHttpClientSuccessHandler)successHandler
                error:(FWHttpClientErrorHandler)errorHandler  {
    NSLog(@"Registration Request Info -- %@",request);
    AFHTTPRequestOperation* requestOperation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation,id responseObject) {
        successHandler(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
    [self.operationQueue addOperation:requestOperation];
}


@end
