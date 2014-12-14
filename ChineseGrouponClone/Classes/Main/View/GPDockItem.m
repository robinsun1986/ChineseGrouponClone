//
//  GPDockItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDockItem.h"

@implementation GPDockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _divider = [[UIImageView alloc] init];
        _divider.frame = CGRectMake(0, 0, kDockItemW, 2);
        _divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        [self addSubview:_divider];
    }
    return self;
}

- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    self.icon = icon;
    self.selectedIcon = selectedIcon;
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setSelectedIcon:(NSString *)selectedIcon
{
    _selectedIcon = selectedIcon;
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDockItemW, kDockItemH);
    [super setFrame:frame];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:NO];
}

@end
