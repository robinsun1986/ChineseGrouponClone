//
//  GPDealListController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealListController.h"
#import "GPDealTopMenu.h"
#import "DPRequest.h"
#import "DPAPI.h"
#import "GPMetaDataTool.h"
#import "GPCity.h"
#import "GPDeal.h"
#import "NSObject+Value.h"
#import "GPDealCell.h"
#import "GPDealTool.h"
#import "MJRefresh.h"
#import "GPImageTool.h"
#import "GPCover.h"
#import "GPDealDetailController.h"
#import "GPNavigationController.h"
#import "UIBarButtonItem+Addition.h"

#define kItemW 250
#define kItemH 250

@interface GPDealListController () <DPRequestDelegate, MJRefreshBaseViewDelegate>
{
    NSMutableArray *_deals;
    int _page; // page
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
}
@end

@implementation GPDealListController

- (NSArray *)totalDeals
{
    return _deals;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1. base setting
    [self baseSetting];
    
    // 2. add refresh
    [self addRefresh];
    
    [GPMetaDataTool sharedGPMetaDataTool].currentCity = [GPMetaDataTool sharedGPMetaDataTool].totalCities[@"北京"];
}

#pragma mark add refresh
-(void)addRefresh
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    _header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    _footer = footer;
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    // pull down to refresh
    if (isHeader) {
        // clear image cache
        [GPImageTool clear];
        _page = 1;
    } else { // pull up to load more
        _page++;
    }
    
    [[GPDealTool sharedGPDealTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
        
        if (isHeader) {
            _deals = [NSMutableArray array];
        }
        
        // 1. add data
        [_deals addObjectsFromArray:deals];
        // 2. refresh table
        [self.collectionView reloadData];
        // 3. end refreshing
        [refreshView endRefreshing];
        // 4. check if the footer needs to be hidden based on total count
        _footer.hidden = (_deals.count >= totalCount);
    } error:^(NSError *error) {
        [refreshView endRefreshing];
    }];
}

#pragma mark base setting
- (void)baseSetting
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    // 1. observe city change notification
    kAddAllNotes(dataChange);
    
    // 2. searchbox in the right
    UISearchBar *s = [[UISearchBar alloc] init];
    s.frame = CGRectMake(0, 0, 210, 35);
    s.placeholder = @"item name, address, etc";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:s];
    
    // 3. menu bar in the left
    GPDealTopMenu *topMenu = [[GPDealTopMenu alloc] init];
    topMenu.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topMenu];
}

- (void)dataChange
{
    [_header beginRefreshing];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end







