//
//  NSString+Utilities.m
//  NetworkFramework
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "NSString+FWUtilities.h"
#import "FWBase64Url.h"

@implementation NSString (FWUtilities)

- (NSString*)decode {
    NSData* decodedData = [FWBase64Url decode:self];
    
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

- (NSString*)encode {
    NSString* encodedString = [FWBase64Url encode:[self dataUsingEncoding:NSUTF8StringEncoding]];
    
    return encodedString;
}

// Encode URL
- (NSString*)URLEncoded {
    NSString* result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (__bridge CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR(":?#[]@!$&’()*+,;="),
                                                                                             kCFStringEncodingUTF8);
    
    return result;
}

// Decode URL
- (NSString*)URLDecoded {
    NSString* result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (__bridge CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
    
    return result;
}

@end
