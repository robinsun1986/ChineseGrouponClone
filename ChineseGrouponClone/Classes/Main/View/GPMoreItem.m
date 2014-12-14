//
//  GPMoreItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPMoreItem.h"
#import "GPMoreController.h"
#import "GPNavigationController.h"

@implementation GPMoreItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setIcon:@"ic_more.png" selectedIcon:@"ic_more_hl.png"];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)moreClick
{
    self.enabled = NO;
    
    GPMoreController *more = [[GPMoreController alloc] init];
    more.moreItem = self;
    GPNavigationController *nav = [[GPNavigationController alloc] initWithRootViewController:more];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
