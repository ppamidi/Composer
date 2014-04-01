//
//  Configuration-Framework.h
//  NetworkFramework
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWConfiguration : NSObject
+ (NSString*)getBaseURL;
+ (NSString*)getSecureBaseURL;
+ (NSString*)getRegistrationURL;
+ (NSString*)getDeviceIdPostKey;
+ (NSString*)getDeviceNamePostKey;
+ (NSString*)getRegistrationRequestType;
+ (NSInteger)getTimeOutInterval;
+ (NSString*)getClientId;
+ (NSString*)getClientSecret;
+ (NSString*)getGrantType;
+ (NSString*)getScope;
+ (NSString*)getWifiSSID;
+ (NSString*)getSecureTokenURL;
+ (NSString*)getRequestSchedularType;
+ (NSString*)getRequestSchedularURL;
+ (NSString*)getDelegationClass;
+ (NSString*)getNotificationInterval;

+ (BOOL)useSecureToken;
+ (BOOL)encryptRequestParams;
+ (BOOL)isSecureRequest;
+ (BOOL)certificateAvialable;
+ (BOOL)publicKeyAvailable;
+ (BOOL)loggingEnabled;

@end
