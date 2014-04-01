//
//  RequestLogFetcher.h
//  Composer
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestLogFetcher;

@interface RequestLogFetcher : NSObject
+ (RequestLogFetcher*)fetcher;
- (int)getTotalRequestsCount;
- (NSArray*)getAllRequests;
@end
