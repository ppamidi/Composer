//
//  Networking.m
//  TSR
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "Networking.h"
#import "Reachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "FWConfiguration.h"

static Reachability *reachability;
@interface Networking ()

+ (BOOL)isConnectedToRightNetwork;

@end

@implementation Networking

+(void)startNetworkMonitor {
    if (!reachability) {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    [reachability startNotifier];
}

+(void)stopNetworkMonitor {
    [reachability stopNotifier];
}

// Check for reachability internet status
+ (HercNetworkStatus)networkStatus {
    if (!reachability) {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus == ReachableViaWWAN) { // Check cellular network connection*/
        
        return NetworkReachable;
    }
    
    if (networkStatus == ReachableViaWiFi) { // Check Wifi network connection
      /*  if ([Networking isConnectedToRightNetwork] == NO) { // Check WLAN-TWDC connection
            
            return WifiNotConnectedToRightSSID;
        } */
        
        return NetworkReachable; // return network connection successfull
    }
    
    return WifiNotReachable;
}

// Check if Wifi is connected to right ssid (WLAN-TWDC)
+ (BOOL)isConnectedToRightNetwork {
    CFArrayRef supportedInterfaces = CNCopySupportedInterfaces();
    if (supportedInterfaces) {
        NSArray* interfaces = (__bridge NSArray*)supportedInterfaces;
        
        NSLog(@"%s: Supported interfaces: %@", __func__, interfaces);
        
        CFRelease(supportedInterfaces);
        
        for (NSString *interfaceName in interfaces) {
            CFDictionaryRef interfaceDict = CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName);
            NSDictionary*  infoDict = (__bridge NSDictionary*)interfaceDict;
            
            NSLog(@"%s: %@ => %@", __func__, interfaceName, infoDict);
            
            if (infoDict) {
                NSString* info = infoDict[@"SSID"];
                CFRelease(interfaceDict);
                
                if ([info isEqualToString:[FWConfiguration getWifiSSID]]) { // Check for SSID read from configuration plist
                    
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

@end
