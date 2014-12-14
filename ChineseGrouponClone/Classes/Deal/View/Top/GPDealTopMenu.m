//
//  GPDealTopMenu.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealTopMenu.h"
#import "GPDealTopMenuItem.h"
#import "GPCategoryMenu.h"
#import "GPDistrictMenu.h"
#import "GPOrderMenu.h"
#import "GPMetaDataTool.h"
#import "GPOrder.h"

@interface GPDealTopMenu()
{
    GPDealTopMenuItem *_selectedItem;
    
    GPCategoryMenu *_cMenu; // category menu
    GPDistrictMenu *_dMenu;  // district menu
    GPOrderMenu *_oMenu; // sort by menu
    
    GPDealBottomMenu *_showingMenu; // the menu being showed at the moment
    GPDealTopMenuItem *_cItem; // category item
    GPDealTopMenuItem *_dItem; // district item
    GPDealTopMenuItem *_oItem; // order item
}
@end

@implementation GPDealTopMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cItem = [self addMenuItem:kAllCategory index:0];
        _dItem = [self addMenuItem:kAllDistrict index:1];
        _oItem = [self addMenuItem:@"Sort By" index:2];
        
        // listen for notification
        kAddAllNotes(dataChange)
        
    }
    return self;
}

- (void)dataChange
{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    // 1. category button
    NSString *c = [GPMetaDataTool sharedGPMetaDataTool].currentCategory;
    if (c) {
        _cItem.title = c;
    }
    
    // 2. district button
    NSString *d = [GPMetaDataTool sharedGPMetaDataTool].currentDistrict;
    if (d) {
        _dItem.title = d;
    }
    
    // 3. order button
    NSString *o = [GPMetaDataTool sharedGPMetaDataTool].currentOrder.name;
    if (o) {
        _oItem.title = o;
    }
    
    // hide bottom menu
    [_showingMenu hide];
    _showingMenu = nil;
}

#pragma mark add one menu item
- (GPDealTopMenuItem *)addMenuItem:(NSString *)title index:(int)index
{
    GPDealTopMenuItem *item = [[GPDealTopMenuItem alloc] init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemW * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    return item;
}

#pragma mark observe the click of top menu item
- (void)itemClick:(GPDealTopMenuItem *)item
{
    if ([GPMetaDataTool sharedGPMetaDataTool].currentCity == nil) {
        return;
    }
    
    _selectedItem.selected = NO;

    if (_selectedItem == item) {
        _selectedItem = nil;
        
        // hide bottom menu
        [self hideBottomMenu:item];
    } else {
        item.selected = YES;
        _selectedItem = item;
        
        [self showBottomMenu];
    }
}

#pragma mark hide bottom menu
- (void)hideBottomMenu:(GPDealTopMenuItem *)item
{
    [_showingMenu hide];
    _showingMenu = nil;
}

#pragma mark show bottom menu
- (void)showBottomMenu
{
    BOOL animated = (_showingMenu == nil);
    
    // remove currently showing menu
    [_showingMenu removeFromSuperview];
    
    // show bottom menu
    if (_selectedItem.tag == 0) { // category
        // make sure menu is created only once
        if (_cMenu == nil) {
            _cMenu = [[GPCategoryMenu alloc] init];
        }
        _showingMenu = _cMenu;
    } else if (_selectedItem.tag == 1) {  // area
        if (_dMenu == nil) {
            _dMenu = [[GPDistrictMenu alloc] init];
        }
        _showingMenu = _dMenu;
    } else { // sort by
        if (_oMenu == nil) {
            _oMenu = [[GPOrderMenu alloc] init];
        }
        _showingMenu = _oMenu;
    }
    
    _showingMenu.frame = _contentView.bounds;
    // to remove reference cycle
    __unsafe_unretained GPDealTopMenu *menu = self;
    _showingMenu.hideBlock = ^{
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        menu->_showingMenu = nil;
    };
    
    [_contentView addSubview:_showingMenu];
    
    // start animation for menu appearance
    if (animated) {
        [_showingMenu show];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(3 * kTopMenuItemW, kTopMenuItemH);
    
    [super setFrame:frame];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
