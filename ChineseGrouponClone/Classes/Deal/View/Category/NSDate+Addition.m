//
//  NSDate+Addition.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)
+ (NSDateComponents *)compareFromDate:(NSDate *)from to:(NSDate *)to
{
    // calendar object (identifier = time zone)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    return [calendar components:flags fromDate:from toDate:to options:0];
}

- (NSDateComponents *)compare:(NSDate *)other
{
    return [NSDate compareFromDate:self to:other];
}
@end
