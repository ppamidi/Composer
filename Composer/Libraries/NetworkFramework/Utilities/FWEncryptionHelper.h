//
//  FWEncryptionHelper.h
//  Framework
//
//  Created by Prasad Pamidi on 3/21/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWEncryptionHelper : NSObject

+ (NSString*)getPassPhrase;
+ (NSData*)decryptData:(NSData*)data;
+ (NSData*)encryptData:(NSData*)data;
@end
