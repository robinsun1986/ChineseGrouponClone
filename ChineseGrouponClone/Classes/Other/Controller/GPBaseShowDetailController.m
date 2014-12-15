//
//  GPBaseShowDetailController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/15/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPBaseShowDetailController.h"

#import "GPCover.h"
#import "GPDealDetailController.h"
#import "GPNavigationController.h"
#import "UIBarButtonItem+Addition.h"

#define kDetailWidth 600

@interface GPBaseShowDetailController ()
{
    GPCover *_cover;
}
@end

@implementation GPBaseShowDetailController
#pragma mark show detail
- (void)showDetail:(GPDeal *)deal
{
    // 1. display the overlay
    if (_cover == nil) {
        _cover = [GPCover coverWithTarget:self action:@selector(hideDetail)];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
    // 2. display deal detail controller
    GPDealDetailController *detail = [[GPDealDetailController alloc] init];
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    GPNavigationController *nav = [[GPNavigationController alloc] initWithRootViewController:detail];
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    
    // when two controllers are child and parent, their views should also be child and parent
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
}

#pragma mark hide detail
- (void)hideDetail
{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    // hide cover
    [UIView animateWithDuration:0.3 animations:^{
        // hide cover
        _cover.alpha = 0;
        
        // hide controller
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

@end
