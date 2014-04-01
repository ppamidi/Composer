//
//  NSString+Utilities.h
//  NetworkFramework
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FWUtilities)
- (NSString*)URLEncoded;
- (NSString*)URLDecoded;
- (NSString*)decode;
- (NSString*)encode;
@end
