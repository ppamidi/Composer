//
//  Directory-framework.h
//  NetworkFramework
//
//  Created by Priyanka p on 13/03/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWDirectory : NSObject

+ (NSString*)filePathForSecureTokenData;
+ (NSString*)cachesDirectory;
+ (NSURL*)applicationCachesDirectory;

@end
