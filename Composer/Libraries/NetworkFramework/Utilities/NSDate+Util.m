//
//  NSDate+Additions.m
//  Hercules
//
//  Created by Priyanka on 11/7/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

- (NSDate*)updateTimeToMidnight {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponets = [[NSDateComponents alloc] init];
    dateComponets.hour = 23;
    dateComponets.minute = 59;
    dateComponets.second = 59;
    
    return [gregorianCalendar dateByAddingComponents:dateComponets toDate:self options:0];
}

@end
