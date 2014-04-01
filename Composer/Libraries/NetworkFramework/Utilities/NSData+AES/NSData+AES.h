//
//  NSData+AES.h
//
//  Created by Ray Konopka on 9/20/2013.
//  Copyright (c) 2013 The Walt Disney Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES)

- (NSData *) encryptAES: (NSString *) key;

- (NSData *) decryptAES: (NSString *) key;

@end
