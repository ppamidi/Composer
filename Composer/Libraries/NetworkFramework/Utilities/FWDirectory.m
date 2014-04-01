//
//  Directory-framework.m
//  NetworkFramework
//
//  Created by Priyanka p on 13/03/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWDirectory.h"

@implementation FWDirectory

+ (NSString*)filePathForSecureTokenData {
    
    return [[FWDirectory cachesDirectory] stringByAppendingPathComponent:@"SecureInfo"];
}

+ (NSString*)cachesDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSURL*)applicationCachesDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString*)deviceRegistrationFilePath {
    return [[FWDirectory cachesDirectory] stringByAppendingPathComponent:@"DeviceRegistration"];
}


@end
