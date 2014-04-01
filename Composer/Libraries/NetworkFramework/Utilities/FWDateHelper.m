//
//  DateHelper.m
//  Hercules
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "FWDateHelper.h"
#import "NSDate+Util.h"

@implementation FWDateHelper

+ (NSDateFormatter *)formatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}

// Get date from string with format "yyyy-MM-dd HH:mm"
+ (NSDate*)dateFromStringFormat1:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSLog(@"dateFromString %@",[formatter dateFromString:dateStr]);
    
    return [formatter dateFromString:dateStr];
}

// Get date from string with format "yyyy-MM-dd HH:mm:ss"
+ (NSDate*)dateFromStringFormat2:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"dateFromString %@",[formatter dateFromString:dateStr]);
    
    return [formatter dateFromString:dateStr];
}

// Get date from string with format "yyyy-MM-dd"
+ (NSDate*)dateFromStringFormat3:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSLog(@"dateFromString %@",[[formatter dateFromString:dateStr] updateTimeToMidnight]);
    return [[formatter dateFromString:dateStr] updateTimeToMidnight]; // This is to consider End of day time (23:59:59)
}

// Get date from string with format "yyyy-MM-dd"
+ (NSDate*)dateFromStringFormat4:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSLog(@"dateFromString %@",[formatter dateFromString:dateStr]);
    return [formatter dateFromString:dateStr];
}

// Get date from string with format "yyyy-MM-dd"
+ (NSDate*)dateFromStringFormat5:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd"];
    
    
    NSLog(@"dateFromString %@",[formatter dateFromString:dateStr]);
    return [formatter dateFromString:dateStr];
}


// Get string from date like format "MM/dd/yyyy"
+ (NSString*)stringFromDateFormat1:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSLog(@"stringFromDate = %@",[formatter stringFromDate:date]);
    
    return [formatter stringFromDate:date];
}

// Get string from date like format "HH:mm"
+ (NSString*)getTimeFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"HH:mm"];
    
    NSLog(@"getExpirytimeFromDate = %@",[formatter stringFromDate:date]);
    
    return [formatter stringFromDate:date];
}

// Get string from date like format "yyyy-MM-dd HH:mm:ss"
+ (NSString*)stringFromDateFormat2:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"stringFromDate = %@",[formatter stringFromDate:date]);
    
    return [formatter stringFromDate:date];
}

// Get string from date like format "yyyy-MM-dd"
+ (NSString*)stringFromDateFormat3:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSLog(@"stringFromDate = %@",[formatter stringFromDate:date]);
    
    return [formatter stringFromDate:date];
}
// Get string from date like format "yyyy-MM-dd"
+ (NSString*)stringFromDateFormat4:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd"];
    
    NSLog(@"stringFromDate = %@",[formatter stringFromDate:date]);
    
    return [formatter stringFromDate:date];
}

// Check if ticket has exceeded present time
+ (BOOL)isExpired:(NSDate*)date {
    NSDate * today = [NSDate date];
    NSComparisonResult result = [today compare:date];
    switch (result) {
        case NSOrderedAscending:
            
            return NO;
        case NSOrderedDescending:
            
            return YES;
        case NSOrderedSame:
            
            return NO;
        default:
            
            return NO;
    }
}

+ (int)daysBetween:(NSDate *)date1 and:(NSDate *)date2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date1 toDate:date2 options:0];
    
    return [components day] + 1;
}

+ (NSDate*)addDays:(NSInteger)noOfDays todate:(NSDate*)date {
    NSDate *newDate = [date dateByAddingTimeInterval: 60 * 60 * 24 * noOfDays];
    
    return newDate;
}

@end
