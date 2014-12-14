//
//  GPCenterLineLabel.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCenterLineLabel.h"

@implementation GPCenterLineLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 1. get context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2. set color
    [self.textColor setStroke];
    // 3. draw line
    CGFloat y = rect.size.height * 0.5 - 5;
    CGContextMoveToPoint(ctx, 0, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width;
    
    CGContextAddLineToPoint(ctx, endX, y);
    // 4. render
    CGContextStrokePath(ctx);
}

@end
