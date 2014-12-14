//
//  GPCover.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/9/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCover.h"

#define kAlpha 0.6

@implementation GPCover

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = kAlpha;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+ (id)cover
{
    return [[self alloc] init];
}

+ (id)coverWithTarget:(id)target action:(SEL)action
{
    GPCover *cover = [self cover];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    return cover;
}

- (void)reset
{
    self.alpha = kAlpha;
}

@end
