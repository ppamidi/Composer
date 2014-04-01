//
//  BaseViewController.m
//  Composer
//
//  Created by Prasad Pamidi on 3/31/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "BaseViewController.h"
#import "FWRegistrationHelper.h"
#import "RequestLog.h"
#import "FWDateHelper.h"
#import "EntityManager.h"
#import "RequestLogFetcher.h"
#import "FWDeviceInfo.h"
#import "ViewController.h"
#import "NSString+FWUtilities.h"


@interface BaseViewController ()
@property (nonatomic) ViewController *controller;

@property (weak, nonatomic) IBOutlet UIButton *btn_reregister;
@property (weak, nonatomic) IBOutlet UILabel *lbl_registrationStatus;
- (IBAction)reRegister:(id)sender;

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _btn_reregister.hidden = YES;
    [self registerDevice];
}


- (void) registerDevice {
    NSLog(@"Total Saved Requests %i", [[RequestLogFetcher fetcher] getTotalRequestsCount]);
    
    RequestLog* log = [[EntityManager entityManager] insertNewEntityForEntityName:NSStringFromClass([RequestLog class])];
    
    log.requestType = @"Registration Request";
    log.requestURL = @"RegisterDevice";
    log.requestMethod = [NSString stringWithFormat:@"%@",[FWConfiguration getRegistrationRequestType]];
    log.requestBody = [NSString stringWithFormat:@"%@",@{@"deviceId": [FWDeviceInfo getDeviceUniqueId], @"deviceName": [FWDeviceInfo getDeviceName]}];
    
    log.requestDateTime = [NSString stringWithFormat:@"%@ %@", [FWDateHelper stringFromDateFormat4:[NSDate date]], [FWDateHelper getTimeFromDate:[NSDate date]]];
    
    /*  [CustomizeManager buildRequestForPath:[NSString stringWithFormat:@"RegisterDevice/%@/1223", [FWDeviceInfo getDeviceUniqueId]] ofType:HTTPMethodPOST withParameters:nil successHandler:^(NSString *responseString) {
     
     } errorHandler:^(NSError *error) {
     
     }];*/
    
    [FWRegistrationHelper registerDeviceWithPath:@"RegisterDevice" parameters:@{@"deviceID": [FWDeviceInfo getDeviceUniqueId], @"deviceName": [[FWDeviceInfo getDeviceName] encode]} successhandler:^(NSString *responseString) {
        _lbl_registrationStatus.text = @"Device Registered Successfully";
        _btn_reregister.hidden = NO;
        
        log.responseCode = [NSNumber numberWithInteger:200];
        log.responseMessage = responseString;
        if (![[EntityManager entityManager] save]) {
            NSLog(@"Unable to save request");
        }
        
        ViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:
                                                 NSStringFromClass([ViewController class])];
        [self.navigationController pushViewController:controller animated:YES];

    }  errorHandler:^(NSError *error) {
        _btn_reregister.hidden = NO;
        _lbl_registrationStatus.text = @"Device Registration Failed";
        log.responseCode = [NSNumber numberWithInteger:error.code];
        log.responseMessage = error.description;
        if (![[EntityManager entityManager] save]) {
            NSLog(@"Unable to save request");
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reRegister:(id)sender {
    [self registerDevice];
}
@end
