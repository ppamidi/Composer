//
//  DeviceInfo-Framework.h
//  NetworkFramework
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWDeviceInfo : NSObject

+ (NSString*)getDeviceUniqueId;
+ (NSString*)getDeviceName;

@end
