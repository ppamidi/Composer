//
//  ViewController.m
//  Composer
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "ViewController.h"
#import "RequestLog.h"
#import "FWDateHelper.h"
#import "RequestLogFetcher.h"
#import "EntityManager.h"
#import "FWDeviceInfo.h"
#import "FWBase64Url.h"
#import "FWRequestDispatcher.h"
#import "FWRequestScheduler.h"
#import "CustomizeManager.h"
#import "NSString+FWUtilities.h"

@interface ViewController () <FWRequestSchedulerDelegate> {
    FWRequestScheduler* scheduler;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
    
    self.navigationItem.leftBarButtonItem = cancel;
}

-(void) popView{
    [scheduler stopRequestScheduler];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self startNotification];
    }
}

- (void)startNotification {
    if (!scheduler) {
        scheduler = [FWRequestScheduler requestScheduler];
    }
    if (!scheduler.schedulerStarted) {
        [scheduler startRequestSchedulerWithReceiverClass:self];
    }else if(!scheduler.schedulerStopped){
        [scheduler stopRequestScheduler];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Composer App" message:@"Request Scheduler Stopped!!" delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

// Delegate method to pass data

- (void)notifyWithData:(FWSchedularInputData)datahandler {
    datahandler (@{@"deviceId": [FWDeviceInfo getDeviceUniqueId], @"deviceName": [FWDeviceInfo getDeviceName]});
}

// Delegate method to handle success/error response

- (void)responseFromScheduler:(id)responseData error:(NSError*)error {
    NSLog(@"Response from scheduler = %@", responseData);
    if (error) {
        NSLog(@"Error from scheduler = %@", error.description);
    }
}

@end
