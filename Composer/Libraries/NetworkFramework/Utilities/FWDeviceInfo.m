//
//  DeviceInfo-Framework.m
//  NetworkFramework
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWDeviceInfo.h"

@implementation FWDeviceInfo
// Get device vendor Id
+ (NSString*)getDeviceUniqueId {
    static NSString* deviceUniqueId = nil;
    if (deviceUniqueId == nil) {
        deviceUniqueId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    
    return deviceUniqueId;
}

// Get device name
+ (NSString*)getDeviceName {
    static NSString* deviceName = nil;
    if (deviceName == nil) {
        deviceName = [[UIDevice currentDevice] name];
    }
    
    return deviceName;
}

@end
