//
//  NSDate+Addition.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)
+ (NSDateComponents *)compareFromDate:(NSDate *)from to:(NSDate *)to;
- (NSDateComponents *)compare:(NSDate *)other;
@end
