//
//  GPTabItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPTabItem.h"

@implementation GPTabItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. set bg image when selected
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
        
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    // check if the separator on the top should be visible
    self.divider.hidden = !enabled;
    [super setEnabled:enabled];
}

@end
