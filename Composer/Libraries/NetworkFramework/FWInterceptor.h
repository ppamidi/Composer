//
//  FWInterceptor.h
//  Framework
//
//  Created by Priyanka on 3/18/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWInterceptor : NSURLProtocol

@property (atomic, strong, readwrite) NSURLConnection* connection;


@end
