//
//  SecureInfo.m
//  TSR
//
//  Created by Priyanka on 3/22/13.
//  Copyright (c) 2013 Capgemini. All rights reserved.
//

#import "FWSecureToken.h"

static  NSString* const kAccessToken = @"access_token";
static  NSString* const kExpireTime = @"expires_in";
static  NSString* const kTokenType = @"token_type";

@implementation FWSecureToken

@synthesize accessToken;
@synthesize expireTime;
@synthesize tokenType;

- (void)setAttributesFromResponse:(NSString*)responseStr {
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    self.accessToken = [dictionary valueForKey:kAccessToken];
    self.tokenType = [dictionary valueForKey:kTokenType];
    
    NSString* expireSeconds = [dictionary valueForKey:kExpireTime];
    NSDate *date = [NSDate dateWithTimeInterval:[expireSeconds integerValue] sinceDate:[NSDate date]];
    
    self.expireTime = date;
    NSLog(@"%@",date);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:kAccessToken];
        self.expireTime = [aDecoder decodeObjectForKey:kExpireTime];
        self.tokenType = [aDecoder decodeObjectForKey:kTokenType];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.accessToken forKey:kAccessToken];
    [aCoder encodeObject:self.expireTime forKey:kExpireTime];
    [aCoder encodeObject:self.tokenType forKey:kTokenType];
}

@end
