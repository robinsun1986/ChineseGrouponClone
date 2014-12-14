//
//  NSString+Price.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/9/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Double)
// generate a string that retain n decimal fraction without the tailing zeros
+ (NSString *)stringWithDouble:(double)value decimal:(int)decimal;
@end
