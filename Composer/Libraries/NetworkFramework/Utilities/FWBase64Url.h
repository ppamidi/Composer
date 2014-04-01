//
//  FWBase64Url.h
//  Framework
//
//  Created by Prasad Pamidi on 3/21/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWBase64Url : NSObject

+ (void) initialize;
+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length;
+ (NSString*) encode:(NSData*) rawBytes;
+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength;
+ (NSData*) decode:(NSString*) string;

@end
