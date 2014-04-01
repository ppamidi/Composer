//
//  NSData+AES.m
//
//  Created by Ray Konopka on 9/20/2013.
//  Copyright (c) 2013 The Walt Disney Company. All rights reserved.
//

#import "NSData+AES.h"

@implementation NSData(AES)


// encryptAES
//
// Encrypts the NSData bytes using AES 128 Block Size, 256 Key size (for the specified key)
// with padding at the end. The returned NSData bytes include the random initialization
// vector that was used during the encryption, followed by the encrypted data bytes.

- (NSData *) encryptAES: (NSString *) key
{
    // Allocation space for key
    char keyPtr[ kCCKeySizeAES256 + 1 ];
    bzero( keyPtr, sizeof( keyPtr ) );
    
    // Copy characters from key into memory referenced by keyPtr
    [key getCString: keyPtr
          maxLength: sizeof( keyPtr )
           encoding: NSUTF8StringEncoding];
    
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];


    // Allocate space for the Initialization Vector and populate with random values
    NSMutableData *iv = [NSMutableData dataWithLength: kCCBlockSizeAES128];
    
    int randomResult;
    randomResult = SecRandomCopyBytes( NULL, kCCBlockSizeAES128, iv.mutableBytes );
    if ( randomResult != 0 )
    {
        // if SecRandomCopyBytes does not work, then simply initialize iv with iv[i]=i
        iv.length = 0;  // Reset the length of iv to 0 so appendBytes works correctly
        
        for ( int i = 0; i < 16; i++)
        {
            NSInteger val = i;
            [iv appendBytes: (void *) &val length: 1];
        }
    }
    
    // Make room for encrypted data and padding
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    
    // Encrypt data using AES 128 Block Size, 256 Key size with padding at the end.

    CCCryptorStatus result = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                      keyPtr, kCCKeySizeAES256,
                                      [iv bytes],
                                      [self bytes], dataLength,
                                      buffer, bufferSize,
                                      &numBytesEncrypted );
    
    if ( result == kCCSuccess )
    {
        // Place the iv at the beginning of the returned data buffer, followed by the enrypted data
        NSMutableData *results = [NSMutableData dataWithData: iv];

        NSData *encData = [NSData dataWithBytesNoCopy: buffer
                                               length: numBytesEncrypted];
       
        [results appendData: encData];
        
        return results;
    }
    
    free( buffer );
    return nil;
}


// decryptAES
//
// Decrypts the NSData bytes using AES 128 Block Size, 256 Key size (for the specified key)
// with padding at the end. The first 16 bytes (128 bits) of NSData bytes are expected
// to be the initialization vector. The decrypted data bytes are returned.

- (NSData *) decryptAES: (NSString *) key
{
    // Allocation space for key
    char  keyPtr[ kCCKeySizeAES256 + 1 ];
    bzero( keyPtr, sizeof( keyPtr ) );
    
    // Copy characters from key into memory referenced by keyPtr
    [key getCString: keyPtr
          maxLength: sizeof( keyPtr )
           encoding: NSUTF8StringEncoding];
    
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length] - kCCBlockSizeAES128;

    
    // Copy the first AESBlockSizeInBytes bytes (16) from Data into IV

    NSData *iv = [NSData dataWithBytes: [self bytes]
                                length: kCCBlockSizeAES128 ];


    size_t bufferSize = dataLength;
    void *buffer_decrypt = malloc( bufferSize );
    
    // Decrypt data using AES 128 Block Size, 256 Key size with padding at the end.
    // Use subdataWithRange to extract the encrypted data that lies after the
    // Initialization Vector, which is at the beginning of the data
    
    CCCryptorStatus result = CCCrypt( kCCDecrypt , kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                      keyPtr, kCCKeySizeAES256,
                                      [iv bytes],
                                      [[self subdataWithRange:NSMakeRange( kCCBlockSizeAES128, dataLength )] bytes],
                                      dataLength,
                                      buffer_decrypt, bufferSize,
                                      &numBytesEncrypted );
    
    if ( result == kCCSuccess )
    {
        return [NSData dataWithBytesNoCopy: buffer_decrypt
                                    length: numBytesEncrypted];
    }
    
    free( buffer_decrypt );
    return nil;
}


@end
