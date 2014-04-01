//
//  FWBackgroundPolling.h
//  Composer
//
//  Created by Priyanka on 3/24/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRequestDispatcher.h"

typedef void(^FWSchedularInputData)(id data);

@protocol FWRequestSchedulerDelegate <NSObject>

- (void)notifyWithData:(FWSchedularInputData)datahandler;

@optional
- (void)responseFromScheduler:(id)responseData error:(NSError*)error;

@end

@interface FWRequestScheduler : NSObject

@property (nonatomic, readonly) id <FWRequestSchedulerDelegate> delegate;
@property (nonatomic, readonly, assign) BOOL schedulerStarted;
@property (nonatomic, readonly, assign) BOOL schedulerStopped;

+ (instancetype)requestScheduler; // returns a new instance of requestDispacther
- (void)startRequestSchedulerWithReceiverClass:(id)receiver;
- (void)stopRequestScheduler;

@end
