//
//  GPDealDetailController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealDetailController.h"
#import "GPDeal.h"
#import "UIBarButtonItem+Addition.h"
#import "GPBuyDock.h"
#import "GPDetailDock.h"
#import "GPDealInfoController.h"
#import "GPDealWebController.h"
#import "GPMerchantController.h"
#import "GPCollectTool.h"

@interface GPDealDetailController () <GPDetailDockDelegate>
{
    GPDetailDock *_detailDock;
}
@end

@implementation GPDealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. baseSetting
    [self baseSetting];
    
    // 2. add buy bar button at the top
    [self addBuyDock];
    
    // 3. add detail dock tab in the right
    [self addDetailDock];
    
    // 4. init child controllers
    [self addAllChildControllers];
}

#pragma mark base setting
-(void)addBuyDock
{    
    GPBuyDock *dock = [GPBuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    [self.view addSubview:dock];
}

#pragma mark dock delegate
- (void)detailDock:(GPDetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
    // remove old views
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    // add new view
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat w = self.view.frame.size.width - _detailDock.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    new.view.frame = CGRectMake(0, 0, w, h);
    [self.view insertSubview:new.view atIndex:0];
}

#pragma mark add all child controllers
-(void)addAllChildControllers
{
    // 1. deal info
    GPDealInfoController *info = [[GPDealInfoController alloc] init];
    info.deal = _deal;
    [self addChildViewController:info];
    // select the first controller by default
    [self detailDock:nil btnClickFrom:0 to:0];
    
    // 1. deal web
    GPDealWebController *web = [[GPDealWebController alloc] init];
    web.deal = _deal;
    [self addChildViewController:web];
    
    // 1. merchant
    GPMerchantController *merchant = [[GPMerchantController alloc] init];
    merchant.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:merchant];
}

#pragma mark detail dock
-(void)addDetailDock
{
    GPDetailDock *dock = [GPDetailDock detailDock];
    CGSize size = dock.frame.size;
    CGFloat x = self.view.frame.size.width - size.width;
    CGFloat y = self.view.frame.size.height - size.height - 100;
    dock.frame = CGRectMake(x, y, 0, 0);
    dock.delegate = self;
    [self.view addSubview:dock];
    _detailDock = dock;
}

#pragma mark base setting
-(void)baseSetting
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    // 1. bg color
    self.view.backgroundColor = kGlobalBg;

    // 2. set title
    self.title = _deal.title;
    
    // 3. handle deal collect property
    [[GPCollectTool sharedGPCollectTool] handleDeal:_deal];

    // 4. bar buttons
    NSString *collectIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";
    
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem itemWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" target:nil action:nil],
        [UIBarButtonItem itemWithIcon:collectIcon highlightedIcon:@"ic_deal_collect_pressed.png" target:self action:@selector(collect)]];
}

#pragma mark collect = favorite
- (void)collect
{
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    
    if (_deal.collected) { // cancel
        [[GPCollectTool sharedGPCollectTool] uncollectDeal:_deal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
    } else { // add
        [[GPCollectTool sharedGPCollectTool] collectDeal:_deal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    }
    
    // send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNote object:nil];
}

@end
