//
//  GPCategoryMenuItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCategoryMenuItem.h"
#import "UIImage+Addition.h"

#define kTitleRatio 0.5

@implementation GPCategoryMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. text center
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 2. image center
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (NSArray *)titles
{
    return _category.subcategories;
}

- (void)setCategory:(GPCategory *)category
{
    _category = category;
    
    // 1. icon
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    
    // 2. title
    [self setTitle:category.name forState:UIControlStateNormal];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kTitleRatio));
}

@end
