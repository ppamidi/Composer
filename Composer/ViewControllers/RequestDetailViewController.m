//
//  RequestDetailViewController.m
//  Composer
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RequestDetailViewController.h"

@interface RequestDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_requestURL;
@property (weak, nonatomic) IBOutlet UILabel *lbl_requestType;
@property (weak, nonatomic) IBOutlet UITextView *txtView_requestBody;
@property (weak, nonatomic) IBOutlet UITextView *txtView_requestHeaders;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ResponseCode;
@property (weak, nonatomic) IBOutlet UITextView *txtView_ResponseMsg;
@end

@implementation RequestDetailViewController

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
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    _lbl_requestType.text = _request.requestMethod;
    _lbl_requestURL.text = _request.requestURL;
    _lbl_ResponseCode.text = [NSString stringWithFormat:@"%@",_request.responseCode];
    _txtView_requestBody.text = _request.requestBody;
    _txtView_requestHeaders.text = _request.requestDateTime;
    _txtView_ResponseMsg.text = _request.responseMessage;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
