//
//  GPDealBottomMenuItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealBottomMenuItem.h"
#import "UIImage+Addition.h"

@implementation GPDealBottomMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. divider in the right
        UIImage *img = [UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 2, kBottomMenuItemH * 0.7);
        divider.center = CGPointMake(kBottomMenuItemW, kBottomMenuItemH * 0.5);
        [self addSubview:divider];
        
        // 2. text color
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        
        // 3. set background of selected
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:(UIControlStateSelected)];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kBottomMenuItemW, kBottomMenuItemH);
    [super setFrame:frame];
}

- (void)setHighlighted:(BOOL)highlighted
{
}

- (NSArray *)titles
{
    return nil;
}

@end
