//
//  GPOrderMenuItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPOrderMenuItem.h"
#import "GPOrder.h"

@implementation GPOrderMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setOrder:(GPOrder *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}

@end
