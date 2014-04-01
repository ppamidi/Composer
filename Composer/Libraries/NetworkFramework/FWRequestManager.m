//
//  FWNetworkManager.m
//  Framework
//
//  Created by Prasad Pamidi on 3/21/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRequestManager.h"
#import "FWRequestDispatcher.h"
#import "FWTokenizer.h"
#import "FWEncryptor.h"
#import "FWRequestLogger.h"
#import "FWEncryptionHelper.h"


static FWRequestDispatcher* requestDispatcher;

@interface FWRequestManager ()

@property (nonatomic, assign) RequestType requestType;
@property (nonatomic, assign) ResponseType responseType;
@property (nonatomic, assign) SSLPinningType sslPinningType;
@property (strong, nonatomic) NSMutableArray *requestInterceptors;

@end

@implementation FWRequestManager

@synthesize requestType = _requestType;
@synthesize responseType = _responseType;
@synthesize sslPinningType = _sslPinningType;

+ (instancetype)requestManager {
    static FWRequestManager* requestmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestmanager = [[FWRequestManager alloc]init];
        [requestmanager initDispatcher];
        
    });
    
    return requestmanager;
}

- (void)initDispatcher {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestDispatcher = [[FWRequestDispatcher alloc] initWithBaseURL:[self baseURL]];
        [self setDefaultConfig];
    });
}

- (NSURL*)baseURL {
    if ([FWConfiguration isSecureRequest]) {
        
        return [NSURL URLWithString:[FWConfiguration getSecureBaseURL]];
    }else {
        return [NSURL URLWithString:[FWConfiguration getBaseURL]];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDispatcher];
    }
    
    return self;
}

- (void)setDefaultConfig  {
    self.responseType = RESPONSE_DEFAULT;
    self.requestType = REQUEST_DEFAULT;
    self.sslPinningType = SSL_PINNING_NONE;
    
    requestDispatcher.requestSerializer = [AFHTTPRequestSerializer serializer];
    requestDispatcher.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    _requestInterceptors = [NSMutableArray array];
    [_requestInterceptors addObjectsFromArray:@[[FWRequestLogger class], [FWEncryptor class], [FWTokenizer class]]];
    
    [self registerAllInterceptors];
}

- (void)setResponseContentType:(ResponseType)responseType {
    _responseType = responseType;
    
    if (_responseType == RESPONSE_JSON) {
        requestDispatcher.responseSerializer = [AFJSONResponseSerializer serializer];
    }else if (_responseType == RESPONSE_XML) {
        requestDispatcher.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }else {
        requestDispatcher.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}

- (void)setRequestType:(RequestType)requestType {
    _requestType = requestType;
    
    if (_requestType == REQUEST_JSON) {
        requestDispatcher.requestSerializer = [AFJSONRequestSerializer serializer];
    }else {
        requestDispatcher.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

- (void)setSSLType:(SSLPinningType)sslType {
    self.sslPinningType = sslType;
    if (_sslPinningType == SSL_PINNING_NONE) {
        [requestDispatcher setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    }else if (_sslPinningType ==  SSL_PINNING_CERTIFICATE) {
        [requestDispatcher setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate]];
    }else if (_sslPinningType ==  SSL_PINNING_PUBLICKEY){
        [requestDispatcher setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    }
}

- (void)setTimeOutInterval:(NSInteger)timeoutValue {
    requestDispatcher.requestSerializer.timeoutInterval = timeoutValue;
}

- (void)setValue:(id)value forHeaderField:(NSString *)key {
    [requestDispatcher.requestSerializer setValue:value forHTTPHeaderField:key];
}

- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password {
    [requestDispatcher.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

- (void)setAuthorizationHeaderFieldWithToken:(NSString *)token {
    [requestDispatcher.requestSerializer setAuthorizationHeaderFieldWithToken:token];
}

- (void)registerInterceptor:(id)interceptor{
    [NSURLProtocol registerClass:[interceptor class]];
}

- (void)clearAuthorizationHeader {
    [requestDispatcher.requestSerializer clearAuthorizationHeader];
}

- (void)unRegisterInterceptor:(id)interceptor{
    [NSURLProtocol unregisterClass:[interceptor class]];
}

- (void)registerAllInterceptors{
    for (id interceptor in _requestInterceptors) {
        [self registerInterceptor:interceptor];
    }
}

- (void)unRegisterAllInterceptors{
    for (id interceptor in _requestInterceptors) {
        [self unRegisterInterceptor:interceptor];
    }
}

- (void) buildRequestForPath:(NSString *)path ofType:(HTTPMethod)method withParameters:(NSDictionary*)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
                errorHandler:(FWHttpClientErrorHandler)errorHandler {
    if (method == HTTPMethodGET) {
        NSMutableDictionary  *params = [parameters mutableCopy];
        if ([FWConfiguration encryptRequestParams]) {
             for (NSString *param in [params allKeys]) {
                [params setObject:[FWBase64Url encode:[FWEncryptionHelper encryptData:[[params objectForKey:param] dataUsingEncoding:NSUTF8StringEncoding]]] forKey:param];
            }
        }
        [requestDispatcher getResource:path withParameters:params successHandler:^(NSString *responseString) {
            successHandler(responseString);
        } error:^(NSError *error) {
            errorHandler(error);
        }];
    } else if(method == HTTPMethodPOST) {
        [requestDispatcher postResource:path withParameters:parameters successHandler:^(NSString *responseString) {
            successHandler(responseString);
        } error:^(NSError *error) {
            errorHandler(error);
        }];
    }
}

+ (void) buildRequestForPath:(NSString *)path ofType:(HTTPMethod)method withParameters:(NSDictionary*)parameters successHandler:(FWHttpClientSuccessHandler)successHandler
                errorHandler:(FWHttpClientErrorHandler)errorHandler {
    [[FWRequestManager requestManager] buildRequestForPath:path ofType:method withParameters:parameters successHandler:^(NSString *responseString) {
        successHandler(responseString);
    } errorHandler:^(NSError *error) {
        errorHandler(error);
    }];
}

@end
