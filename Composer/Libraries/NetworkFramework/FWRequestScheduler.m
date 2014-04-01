//
//  FWBackgroundPolling.m
//  Composer
//
//  Created by Priyanka on 3/24/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "FWRequestScheduler.h"
#import "FWConfiguration.h"
#import "FWRequestManager.h"
#import "Reachability.h"
#import "Networking.h"

#define MIN_DELAY 0

@interface FWRequestScheduler () {
}

@property (nonatomic, assign) BOOL schedulerStarted;
@property (nonatomic, assign) BOOL schedulerStopped;
@property (nonatomic, strong) FWRequestScheduler* requestScheduler;

@end


@implementation FWRequestScheduler
@synthesize schedulerStarted = _schedulerStarted;
@synthesize schedulerStopped = _schedulerStopped;
@synthesize delegate = _delegate;

+ (instancetype)requestScheduler {

    return [[[self class]alloc]init];
}

- (instancetype)init {
    if (!self) {
        self = [super init];
    }
    
    _schedulerStarted = NO;
    _schedulerStopped = NO;
    
    return self;
}

- (void)startNetworkNotifier {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged) name:kReachabilityChangedNotification object:nil];
    [Networking startNetworkMonitor];
}

- (void)networkStatusChanged {
    if ([Networking networkStatus] == NetworkReachable) {
        [self scheduleNextNotificationWithDelay:MIN_DELAY];
    }
}

- (void)startRequestSchedulerWithReceiverClass:(id)receiver {
    _delegate = receiver;
    _schedulerStarted = YES;
    _schedulerStopped = NO;
    [self startNetworkNotifier];
    [self scheduleNextNotificationWithDelay:MIN_DELAY];
}

- (void)stopRequestScheduler {
     _schedulerStarted = NO;
     _schedulerStopped = YES;
    
    [Networking stopNetworkMonitor];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)getDataToPostFromSender {
    NSLog(@"%@", [FWConfiguration getRequestSchedularURL]);
    if ([_delegate respondsToSelector:@selector(notifyWithData:)])
        [_delegate notifyWithData:^(id data) {
            [FWRequestManager buildRequestForPath:[FWConfiguration getRequestSchedularURL] ofType:[[FWConfiguration getRequestSchedularType] intValue] withParameters:data successHandler:^(NSString *responseString) {
                [self responseFromSchedler:responseString error:nil];
            } errorHandler:^(NSError *error) {
                [self responseFromSchedler:nil error:error];
            }];
        }];
}

- (void)responseFromSchedler:(NSString*)responseStr error:(NSError*)error {
    [_delegate responseFromScheduler:responseStr error:error];
    if (!_schedulerStopped) {
        if ([Networking networkStatus] == NetworkReachable) {
            [self scheduleNextNotificationWithDelay:[[FWConfiguration getNotificationInterval]intValue]];
        }
    }
}

- (void)scheduleNextNotificationWithDelay:(NSInteger)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        if (!self.schedulerStopped) {
            [self getDataToPostFromSender];
        }
    });
}

@end
