//
//  AppDelegate.h
//  Composer
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
AppDelegate* appDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (assign, nonatomic) UIStoryboard* storyboard;
@property (strong, nonatomic) UIWindow *window;

@end
