//
//  FWEncryptionHelper.m
//  Framework
//
//  Created by Prasad Pamidi on 3/21/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWEncryptionHelper.h"
#import "NSData+AES.h"

@implementation FWEncryptionHelper

+ (NSData*)encryptData:(NSData*)data{
    
    return [data encryptAES:[FWEncryptionHelper getPassPhrase]];
}

+ (NSData*)decryptData:(NSData*)data{
    
    return [data decryptAES:[FWEncryptionHelper getPassPhrase]];
}

// Method to generate random passphrase for encryption
+ (NSString*)getPassPhrase
{
    int A, B, C, D, E, F, G;
    int H, I, J, K, L;
    float M = 15.25f;
    J = 105; A = 74; B = 65; F = 37; H = 87; D = 91;
    C = 124; K = 89; G = 10 * 11; E = 119; I = 86; L = 48;
    NSString *result =
    [NSString stringWithFormat: @"%c%c%c%d%c%c%c%c%d%c%d%c%c%c%d%c%c%d%c%c%c",
     A, E, K, [[NSNumber numberWithFloat: 47.5 * 2] intValue], H, D, E - L, G, D, C,
     3000+700+23, B, J, F, (int) ( M*40+L ), E-A, H - 4, C*I, L, I - 12, J + 16 ];
    
    return result;
}

@end
