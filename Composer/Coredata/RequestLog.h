//
//  RequestLog.h
//  Composer
//
//  Created by Prasad Pamidi on 3/22/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RequestLog : NSManagedObject

@property (nonatomic, retain) NSString * requestBody;
@property (nonatomic, retain) NSString * requestDateTime;
@property (nonatomic, retain) NSString * requestHeaders;
@property (nonatomic, retain) NSString * requestMethod;
@property (nonatomic, retain) NSString * requestType;
@property (nonatomic, retain) NSString * requestURL;
@property (nonatomic, retain) NSNumber * responseCode;
@property (nonatomic, retain) NSString * responseMessage;

@end
