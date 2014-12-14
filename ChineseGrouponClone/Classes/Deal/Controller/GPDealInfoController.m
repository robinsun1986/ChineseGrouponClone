//
//  GPDealInfoController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealInfoController.h"
#import "GPInfoHeaderView.h"
#import "GPDealTool.h"
#import "GPDeal.h"
#import "GPRestriction.h"
#import "GPInfoHeaderView.h"
#import "GPInfoTextView.h"

#define kVMargin 20

@interface GPDealInfoController ()
{
    UIScrollView *_scrollView;
    GPInfoHeaderView *_header;
}
@end

@implementation GPDealInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. add scroll view
    [self addScrollView];
    
    // 2. add header view
    [self addHeaderView];
    
    // 3. load detailed deal info
    [self loadDetailDeal];
}

#pragma mark load detail deal
- (void)loadDetailDeal
{
    [[GPDealTool sharedGPDealTool] dealWithID:_deal.deal_id success:^(GPDeal *deal) {
//        MyLog(@"\n%@\n%@\n%d", deal.details, deal.restrictions.special_tips, deal.restrictions.is_refundable);
        _deal = deal;
        _header.deal = deal;
        
        // add detail info
        [self addDetailViews];
    } error:nil];
}

#pragma mark add detail data (other controller)
- (void)addDetailViews
{
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_header.frame) + kVMargin);
    
    // 1. detail info
    [self addTextView:@"ic_content.png" title:@"团购详情" content:_deal.details];
    
    // 2. special tips
    [self addTextView:@"ic_tip.png" title:@"团购须知" content:_deal.restrictions.special_tips];
    
    // 3. notice
    [self addTextView:@"ic_tip.png" title:@"重要通知" content:_deal.notice];
}

#pragma mark add one GPInfoTextView
- (void)addTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if (content.length == 0) return;
    
    // 0. create textview
    GPInfoTextView *textView = [GPInfoTextView infoTextView];
    
    CGFloat y = _scrollView.contentSize.height;
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = textView.frame.size.height;
    textView.frame = CGRectMake(0, y, w, h);
    
    // 2. text properties
    textView.title = title;
    textView.content = content;
    textView.icon = icon;

    // 3. add to scroll view
    [_scrollView addSubview:textView];
    
    // 4. set content size for scroll view
    CGFloat contentH = CGRectGetMaxY(textView.frame) + kVMargin;
    _scrollView.contentSize = CGSizeMake(0, contentH);
}

#pragma mark add scroll view
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounds = CGRectMake(0, 0, 430, self.view.frame.size.height);
    CGFloat x = self.view.frame.size.width * 0.5;
    CGFloat y = self.view.frame.size.height * 0.5;
    scrollView.center = CGPointMake(x, y);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    // remove the 2 default subviews from scroll view
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    CGFloat topMargin = 70;
    scrollView.contentInset = UIEdgeInsetsMake(topMargin, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -topMargin);
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

#pragma mark add header view
- (void)addHeaderView
{
    GPInfoHeaderView *header = [GPInfoHeaderView infoHeaderView];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width, header.frame.size.height);
    header.deal = _deal;
    [_scrollView addSubview:header];
    _header = header;
}

@end
