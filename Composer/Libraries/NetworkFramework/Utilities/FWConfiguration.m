//
//  Configuration-Framework.m
//  NetworkFramework
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWConfiguration.h"
#import "FWConstants.h"

@implementation FWConfiguration

+ (NSString*)getBaseURL {
    return [[FWConfiguration dictionary] objectForKey:kBaseURL];
}

+ (NSString*)getSecureBaseURL {
    return [[FWConfiguration dictionary] objectForKey:kSecureBaseURL];
}

+ (NSString*)getDeviceIdPostKey {
    return [[FWConfiguration dictionary] objectForKey:kDeviceNameKey];
}

+ (NSString*)getDeviceNamePostKey {
    return [[FWConfiguration dictionary] objectForKey:kRegistrationURL];
}

+ (NSDictionary*)getRegistrationRequestInfoDict {
    return [[FWConfiguration dictionary] objectForKey:kRegistrationRequestInfo];
}

+ (NSDictionary*)getPollingRequestInfoDict {
    return [[FWConfiguration dictionary] objectForKey:kPollingRequestInfo];
}

+ (NSString*)getRegistrationURL {
    return [[FWConfiguration dictionary] objectForKey:kRegistrationURL];
}

+ (NSString*)getRegistrationRequestType {
    return [[FWConfiguration getRegistrationRequestInfoDict] objectForKey:kRegistrationRequestType];
}

+ (NSString*)getRequestSchedularURL{
    return [[FWConfiguration getPollingRequestInfoDict] objectForKey:kPollingRequestURL];
}

+ (NSString*)getRequestSchedularType{
    return [[FWConfiguration getPollingRequestInfoDict] objectForKey:kPollingRequestType];
}

+ (NSString*)getDelegationClass {
    return [[FWConfiguration getPollingRequestInfoDict] objectForKey:kDelegateClass];
}

+ (NSString*)getNotificationInterval {
    return [[FWConfiguration getPollingRequestInfoDict] objectForKey:kNotificationInterval];
}

+ (BOOL)isSecureRequest {
    return [[[FWConfiguration dictionary] objectForKey:kSecureRequest] boolValue];
}

+ (BOOL)useSecureToken {
    return [[[FWConfiguration dictionary] objectForKey:kUseSecureToken] boolValue];
}

+ (BOOL) loggingEnabled {
     return [[[FWConfiguration dictionary] objectForKey:kloggingEnabled] boolValue];
}

+ (BOOL)encryptRequestParams {
     return [[[FWConfiguration dictionary] objectForKey:kEncryptParams] boolValue];
}

+ (NSInteger)getTimeOutInterval {
     return [[[FWConfiguration dictionary] objectForKey:kRequestTimeOut] intValue];
}

+ (NSDictionary*)getSecureTokenInfoDict {
    return [[FWConfiguration dictionary] objectForKey:kSecureTokenInfo];
}

+ (NSString*)getSecureTokenURL {
    return [[FWConfiguration dictionary] objectForKey:kSecureTokenURL];
}

+ (NSString*)getClientId {
    return [[FWConfiguration getSecureTokenInfoDict] objectForKey:kClientId];
}

+ (NSString*)getClientSecret {
    return [[FWConfiguration getSecureTokenInfoDict] objectForKey:kClientSecret];
}

+ (NSString*)getGrantType {
    return [[FWConfiguration getSecureTokenInfoDict] objectForKey:kGrantType];
}

+ (NSString*)getScope {
    return [[FWConfiguration getSecureTokenInfoDict] objectForKey:kScope];
}

+ (NSString*)getWifiSSID {
    return [[FWConfiguration dictionary] objectForKey:kWifiSSID];
}

+ (BOOL)certificateAvialable {
    return [[[FWConfiguration dictionary] objectForKey:kCertificateAvailable] boolValue];
}

+ (BOOL)publicKeyAvailable {
    return [[[FWConfiguration dictionary] objectForKey:kPublicKeyAvailable] boolValue];
}

+ (NSString*)configurationFilePath {
    NSString *str = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
    if (str) {
        return str;
    }
    
    return nil;
}

+ (NSDictionary*)dictionary {
    
    return [NSDictionary dictionaryWithContentsOfFile:[FWConfiguration configurationFilePath]];
}

@end
