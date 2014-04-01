//
//  FWHttpClient.h
//  Framework
//
//  Created by Priyanka on 3/17/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "FWConfiguration.h"
#import "FWInterceptor.h"

typedef enum {
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodHEAD,
    HTTPMethodPUT,
    HTTPMethodDELETE,
} HTTPMethod;


typedef enum {
    REQUEST_DEFAULT,
    REQUEST_JSON,
} RequestType;

typedef enum {
    RESPONSE_DEFAULT,
    RESPONSE_JSON,
    RESPONSE_XML,
} ResponseType;

typedef enum {
    SSL_PINNING_NONE,
    SSL_PINNING_CERTIFICATE,
    SSL_PINNING_PUBLICKEY,
} SSLPinningType;

@interface FWRequestDispatcher : AFHTTPRequestOperationManager

typedef void(^FWHttpClientSuccessHandler)(NSString* responseString);
typedef void(^FWHttpClientErrorHandler)(NSError* error);

- (instancetype)initWithBaseURL:(NSURL *)url;

- (void)getResource:(NSString*)path withParameters:(NSDictionary *)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
              error:(FWHttpClientErrorHandler)errorHandler;
- (void)postResource:(NSString*)path withParameters:(NSDictionary *)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
               error:(FWHttpClientErrorHandler)errorHandler;

@end
