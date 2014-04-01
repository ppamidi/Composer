//
//  NSString+URL.h
//  Hercules
//
//  Created by Priyanka on 9/13/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

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
