//
//  FWRequestLogger.h
//  Composer
//
//  Created by Prasad Pamidi on 3/31/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWInterceptor.h"

@interface FWRequestLogger : FWInterceptor

-(void) requestLoggingComplete:(NSMutableDictionary *) requestLog;
@end
