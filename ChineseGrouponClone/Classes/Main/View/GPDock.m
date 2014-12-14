//
//  GPDock.m
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//


#import "GPDock.h"
#import "GPMoreItem.h"
#import "GPLocationItem.h"
#import "GPDockItem.h"
#import "GPTabItem.h"

@interface GPDock ()
{
    GPTabItem *_selectedItem;
}
@end

@implementation GPDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. auto-resize (height + right margin)
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        // 2. set background color
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        
        // 3. add logo
        [self addLogo];
        
        // 4. add tabs
        [self addTabs];
        
        // 5. add location
        [self addLocation];
        
        // 6. add more
        [self addMore];
    }
    return self;
}

#pragma mark add tabs
- (void)addTabs
{
    // 1. deal
    [self addSingleTab:@"ic_deal.png" selectedIcon:@"ic_deal_hl.png" index:1];
    // 2. map
    [self addSingleTab:@"ic_map.png" selectedIcon:@"ic_map_hl.png" index:2];
    // 3. collect
    [self addSingleTab:@"ic_collect.png" selectedIcon:@"ic_collect_hl.png" index:3];
    // 4. mine
    [self addSingleTab:@"ic_mine.png" selectedIcon:@"ic_mine_hl.png" index:4];
    // 5. add separator at the bottom of the last tab
    UIImageView *divider = [[UIImageView alloc] init];
    divider.frame = CGRectMake(0, kDockItemH * 5, kDockItemW, 2);
    divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
    [self addSubview:divider];
}

#pragma mark add single tab
- (void)addSingleTab:(NSString *)icon selectedIcon:(NSString *)selectedIcon index:(int)index
{
    GPTabItem *tab = [[GPTabItem alloc] init];
    [tab setIcon:icon selectedIcon:selectedIcon];
    tab.frame = CGRectMake(0, kDockItemH * index, 0, 0);
    [tab addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tab];
    tab.tag = index;
    if(index == 1) {
        [self tabClick:tab];
    }
}

#pragma mark observe table click
- (void)tabClick:(GPTabItem *)tab
{
    // 1. notify delegate
    if ([_delegate respondsToSelector:@selector(dock:tabChangeFrom:to:)]) {
        [_delegate dock:self tabChangeFrom:_selectedItem.tag to:tab.tag];
    }
    
    // 2. manage state
    _selectedItem.enabled = YES;
    tab.enabled = NO;
    _selectedItem = tab;
}

#pragma mark add location
- (void)addLocation
{
    GPLocationItem *loc = [[GPLocationItem alloc] init];
    CGFloat y = self.frame.size.height - kDockItemH * 2;
    loc.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:loc];
}

#pragma mark add more
- (void)addMore
{
    GPMoreItem *more = [[GPMoreItem alloc] init];
    CGFloat y = self.frame.size.height - kDockItemH;
    more.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:more];
}

#pragma mark add logo
- (void)addLogo
{
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"ic_logo.png"];
    CGFloat scale = 0.7;
    CGFloat logoW = logo.image.size.width * scale;
    CGFloat logoH = logo.image.size.height * scale;
    logo.bounds = CGRectMake(0, 0, logoW, logoH);
    logo.center = CGPointMake(kDockItemW * 0.5, kDockItemH * 0.5);
    
    [self addSubview:logo];
    
    //        UIButton *logo = [[UIButton alloc] init];
    //        logo.enabled = NO;
    //        logo.adjustsImageWhenDisabled = NO;
    //        logo.contentEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    //        [logo setImage:[UIImage imageNamed:@"ic_logo.png"] forState:UIControlStateNormal];
}

#pragma mark set fixed width
- (void)setFrame:(CGRect)frame
{
    frame.size.width = kDockItemW;
    [super setFrame:frame];
}

@end
