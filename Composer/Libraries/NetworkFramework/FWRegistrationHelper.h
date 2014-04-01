//
//  FWRegistrationHelper.h
//  Framework
//
//  Created by Priyanka on 3/20/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRequestDispatcher.h"

@interface FWRegistrationHelper : NSObject 

// Class method for GET request with path for registration retrieved from Config.plist
// appended by device vendor ID and device name.

+ (void)registerDeviceWithSuccesshandler:(FWHttpClientSuccessHandler)successHandler
                                               errorHandler:(FWHttpClientErrorHandler)errorHandler;

// Class method for GET request with path provided by user, which is
// appended with device vendor ID and device name.

+ (void)registerDeviceWithPath:(NSString*)path parameters:(NSDictionary *)parameters successhandler:(FWHttpClientSuccessHandler)successHandler
                  errorHandler:(FWHttpClientErrorHandler)errorHandler;


@end
