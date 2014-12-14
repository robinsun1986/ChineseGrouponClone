//
//  UIBarButtonItem+Addition.m
//  ChineseTwitterClone
//
//  Created by wilson on 8/28/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"

@implementation UIBarButtonItem (Addition)

- (id)initwithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    // create button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:icon];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    
    // set left button size
    btn.bounds = (CGRect){CGPointZero, image.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    return [[self alloc] initwithIcon:icon highlightedIcon:highlighted target:target action:action];
}

@end
