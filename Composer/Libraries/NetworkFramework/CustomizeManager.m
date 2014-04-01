//
//  CustomizeManager.m
//  Composer
//
//  Created by Priyanka on 3/27/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "CustomizeManager.h"

@implementation CustomizeManager

+ (CustomizeManager*)customizeManager {
    return [super requestManager];
}

+ (void)buildRequestForPath:(NSString *)path ofType:(HTTPMethod)method withParameters:(NSDictionary *)parameters successHandler:(FWHttpClientSuccessHandler)successHandler errorHandler:(FWHttpClientErrorHandler)errorHandler {
    
   [[CustomizeManager customizeManager] setValue:@"ased" forHeaderField:@"qwerty"];
    [super buildRequestForPath:path ofType:HTTPMethodGET withParameters:parameters successHandler:^(NSString *responseString) {
        successHandler(responseString);
    } errorHandler:^(NSError *error) {
        errorHandler(error);
    }];
}

 @end
