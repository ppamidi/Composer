//
//  FWNetworkManager.h
//  Framework
//
//  Created by Prasad Pamidi on 3/21/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWRequestDispatcher.h"
#import "FWBase64Url.h"

@interface FWRequestManager : NSObject

+ (instancetype)requestManager;

+ (void) buildRequestForPath:(NSString *)path ofType:(HTTPMethod)method withParameters:(NSDictionary*)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
                errorHandler:(FWHttpClientErrorHandler)errorHandler;
- (void)buildRequestForPath:(NSString *)path ofType:(HTTPMethod)method withParameters:(NSDictionary *)parameters successHandler:(FWHttpClientSuccessHandler)successHandler errorHandler:(FWHttpClientErrorHandler)errorHandler;

- (void)setResponseContentType:(ResponseType)responseType;
- (void)setRequestType:(RequestType)requestType;
- (void)setSSLType:(SSLPinningType)sslPinningType;
- (void)setValue:(id)value forHeaderField:(NSString *)key;
- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password;
- (void)setTimeOutInterval:(NSInteger)timeoutValue;

/**
 Sets the "Authorization" HTTP header set in request objects made by the HTTP client to a token-based authentication value, such as an OAuth access token. This overwrites any existing value for this header.
 
 @param token The authentication token
 */
- (void)setAuthorizationHeaderFieldWithToken:(NSString *)token;


/**
 Clears any existing value for the "Authorization" HTTP header.
 */
- (void)clearAuthorizationHeader;


- (void)registerInterceptor:(FWInterceptor*)interceptor;
- (void)unRegisterInterceptor:(FWInterceptor*)interceptor;
- (void)unRegisterAllInterceptors;
- (void)registerAllInterceptors;

@end
