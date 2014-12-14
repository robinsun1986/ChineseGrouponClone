//
//  GPDealTopMenuItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#define kTitleScale 0.8

#import "GPDealTopMenuItem.h"

@implementation GPDealTopMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // text color
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        
        // set arrow
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // divider in the right
        UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 2, kTopMenuItemH * 0.7);
        divider.center = CGPointMake(kTopMenuItemW, kTopMenuItemH * 0.5);
        [self addSubview:divider];
        
        // selected background
        [self setBackgroundImage:[UIImage imageNamed:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat w = contentRect.size.width * kTitleScale;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat x = contentRect.size.width * kTitleScale;
    CGFloat w = contentRect.size.width - x;
    return CGRectMake(x, 0, w, h);
}

@end



















