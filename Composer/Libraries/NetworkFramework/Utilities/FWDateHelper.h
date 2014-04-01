//
//  DateHelper.h
//  Hercules
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWDateHelper : NSObject

+ (NSDate*)dateFromStringFormat1:(NSString*)dateStr;
+ (NSDate*)dateFromStringFormat2:(NSString*)dateStr;
+ (NSDate*)dateFromStringFormat3:(NSString*)dateStr;
+ (NSDate*)dateFromStringFormat4:(NSString*)dateStr;
+ (NSString*)getTimeFromDate:(NSDate*)date;
+ (NSString*)stringFromDateFormat1:(NSDate*)date;
+ (NSString*)stringFromDateFormat2:(NSDate*)date;
+ (NSString*)stringFromDateFormat3:(NSDate*)date;
+ (BOOL) isExpired:(NSDate*)date;
+ (int)daysBetween:(NSDate *)date1 and:(NSDate *)date2;
+ (NSDate*)addDays:(NSInteger)noOfDays todate:(NSDate*)date;
+ (NSDate*)dateFromStringFormat5:(NSString*)dateStr;
+ (NSString*)stringFromDateFormat4:(NSDate*)date;

@end
