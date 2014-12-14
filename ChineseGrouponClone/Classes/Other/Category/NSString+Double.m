//
//  NSString+Price.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/9/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "NSString+Double.h"

@implementation NSString (Double)
+ (NSString *)stringWithDouble:(double)value decimal:(int)decimal
{
    if (decimal < 0) {
        return nil;
    }
    
    NSString *fmt = [NSString stringWithFormat:@"%%.%df", decimal];
    NSString *str = [NSString stringWithFormat:fmt, value];
    if ([str rangeOfString:@"."].length == 0) {
        return str;
    }
    
    // remove the tailing zero and dot
    int index = str.length - 1;
    for (; TRUE; index--) {
        unichar ch = [str characterAtIndex:index];
        
        if (ch == '.') {
            break;
        }
        
        if (ch != '0') {
            index++;
            break;
        }
    }
    
    return [str substringToIndex:index];
}
@end
