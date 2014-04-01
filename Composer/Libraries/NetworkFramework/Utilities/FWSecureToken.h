//
//  SecureInfo.h
//  TSR
//
//  Created by Priyanka on 3/22/13.
//  Copyright (c) 2013 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWSecureToken : NSObject <NSCoding>

@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSDate * expireTime;
@property (nonatomic, retain) NSString * tokenType;

- (void)setAttributesFromResponse:(NSString*)responseStr;

@end
