//
//  FWRegistrationHelper.m
//  Framework
//
//  Created by Priyanka on 3/20/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRegistrationHelper.h"
#import "FWDeviceInfo.h"
#import "NSString+FWUtilities.h"
#import "FWRequestManager.h"

@implementation FWRegistrationHelper

+ (void)registerDeviceWithSuccesshandler:(FWHttpClientSuccessHandler)successHandler
                                               errorHandler:(FWHttpClientErrorHandler)errorHandler {
    NSString* requestPath = [NSString stringWithFormat:@"%@/%@", [FWConfiguration getRegistrationURL], [FWDeviceInfo getDeviceUniqueId]];
    
    [FWRequestManager buildRequestForPath:requestPath ofType:[[FWConfiguration getRegistrationRequestType] intValue] withParameters:nil successHandler:successHandler errorHandler:errorHandler];
}

+ (void)registerDeviceWithPath:(NSString*)path parameters:(NSDictionary *)parameters successhandler:(FWHttpClientSuccessHandler)successHandler
                            errorHandler:(FWHttpClientErrorHandler)errorHandler {
    NSString* requestPath = [NSString stringWithFormat:@"%@/%@/%@", path, [FWDeviceInfo getDeviceUniqueId], [[FWDeviceInfo getDeviceName] encode]];
    
    [FWRequestManager buildRequestForPath:requestPath ofType:[[FWConfiguration getRegistrationRequestType] intValue] withParameters:parameters successHandler:successHandler errorHandler:errorHandler];
}

@end
