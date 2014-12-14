//
//  NSString+Addition.m
//  ChineseTwitterClone
//
//  Created by wilson on 8/27/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

-(NSString *)fileAppend:(NSString *)append
{
    NSString *ext = [self pathExtension];
    NSString *imgName = [self stringByDeletingPathExtension];
    imgName = [imgName stringByAppendingString:append];
    
    return [imgName stringByAppendingPathExtension:ext];
}



@end
