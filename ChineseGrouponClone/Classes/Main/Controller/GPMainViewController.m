//
//  GPMainViewController.m
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPMainViewController.h"
#import "GPDock.h"
#import "GPCollectController.h"
#import "GPMapController.h"
#import "GPMineController.h"
#import "GPDealListController.h"
#import "GPNavigationController.h"

@interface GPMainViewController () <GPDockDelegate>
{
    UIView *_contentView;
}
@end

@implementation GPMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor redColor];
    
    //NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    // 1. add dock
    GPDock *dock = [[GPDock alloc] init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    [self.view addSubview:dock];
    dock.delegate = self;
    
    // 2. add content view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - kDockItemW;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(kDockItemW, 0, w, h);
    [self.view addSubview:_contentView];
    
    // 3. add child controllers
    [self addAllChildControllers];
}

#pragma mark add child controllers
- (void)addAllChildControllers
{
    // 1. deal
    GPDealListController *deal = [[GPDealListController alloc] init];
    //deal.view.backgroundColor = [UIColor blackColor];
    GPNavigationController *nav1 = [[GPNavigationController alloc] initWithRootViewController:deal];
    [self addChildViewController:nav1];
    
    // 2. map
    GPMapController *map = [[GPMapController alloc] init];
    map.view.backgroundColor = [UIColor yellowColor];
    GPNavigationController *nav2 = [[GPNavigationController alloc] initWithRootViewController:map];
    [self addChildViewController:nav2];
    
    // 3. collect
    GPCollectController *collect = [[GPCollectController alloc] init];
    collect.view.backgroundColor = [UIColor greenColor];
    GPNavigationController *nav3 = [[GPNavigationController alloc] initWithRootViewController:collect];
    [self addChildViewController:nav3];
    
    // 4. mine
    GPMineController *mine = [[GPMineController alloc] init];
    mine.view.backgroundColor = [UIColor blueColor];
    GPNavigationController *nav4 = [[GPNavigationController alloc] initWithRootViewController:mine];
    [self addChildViewController:nav4];
    
    // 5. select the deal controller by default
    [self dock:nil tabChangeFrom:1 to:1];
}

#pragma mark click certain dock item
- (void)dock:(GPDock *)dock tabChangeFrom:(int)from to:(int)to
{
//    MyLog(@"%d - %d", from, to);
//    MyLog(@"w=%d, h=%d", from, to);
    
    // 1. remove old controller
    UIViewController *old = self.childViewControllers[from-1];
    [old.view removeFromSuperview];
    
    // 2. add new controller
    UIViewController *new = self.childViewControllers[to-1];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];

    //MyLog(@"w=%f, h=%f", new.view.bounds.size.width, new.view.bounds.size.height);
}

@end





















