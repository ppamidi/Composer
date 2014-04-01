//
//  Networking.h
//  TSR
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Network {
    NetworkReachable,
    NetworkNotReachable,
    WifiNotReachable,
    WifiNotConnectedToRightSSID,
    ServerError
}HercNetworkStatus;

@interface Networking : NSObject

+(void)startNetworkMonitor;
+(void)stopNetworkMonitor;
+ (HercNetworkStatus)networkStatus;
+ (BOOL)isConnectedToRightNetwork;

@end
