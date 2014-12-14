//
//  GPRoundRectView.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPRoundRectView.h"
#import "UIImage+Addition.h"

@implementation GPRoundRectView

-(void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

@end
