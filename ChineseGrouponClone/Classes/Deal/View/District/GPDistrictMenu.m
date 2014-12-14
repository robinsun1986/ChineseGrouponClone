//
//  GPDistrictMenu.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDistrictMenu.h"
#import "GPDistrictMenuItem.h"
#import "GPMetaDataTool.h"
#import "GPCity.h"
#import "GPDistrict.h"
#import "GPMetaDataTool.h"
#import "GPSubtitlesView.h"

@interface GPDistrictMenu ()
{
    NSMutableArray *_menuItems;
}
@end

@implementation GPDistrictMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuItems = [NSMutableArray array];
        
        [self cityChange];
        
        // observe city change
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    }
    return self;
}

- (void)cityChange
{
    // get the current selected city
    GPCity *city = [GPMetaDataTool sharedGPMetaDataTool].currentCity;
    // 2. all districts for the current city
    NSMutableArray *districts = [NSMutableArray array];
    // 2.1 add "all" districts
    GPDistrict *all = [[GPDistrict alloc] init];
    all.name = kAllDistrict;
    [districts addObject:all];
    // 2.2 add other districts
    [districts addObjectsFromArray:city.districts];
    
    // 3. traverse all districts
    int count = districts.count;
    for (int i = 0; i < count; i++) {
        
        GPDistrictMenuItem *item = nil;
        if (i >= _menuItems.count) {
            // create district menu item
            item = [[GPDistrictMenuItem alloc] init];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_menuItems addObject:item];
            [_scrollView addSubview:item];
        } else {
            item = _menuItems[i];
        }
        
        item.hidden = NO;
        item.district = districts[i];
        item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
        
        if (i == 0) {
            item.selected = YES;
            _selectedItem = item;
        } else {
            item.selected = NO;
        }
    }
    
    // 4. hide extra item
    for (int i = count; i<_menuItems.count; i++) {
        GPDistrictMenuItem *item = _scrollView.subviews[i];
        item.hidden = YES;
    }
    
    // 5. set content size
    _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    
    // 6. hide subtitles view
    [_subtitlesView hide];
}

- (void)settingSubtitlesView
{
    _subtitlesView.setTitleBlock = ^(NSString *title) {
        [GPMetaDataTool sharedGPMetaDataTool].currentDistrict = title;
    };
    
    _subtitlesView.getTitleBlock = ^{
        return [GPMetaDataTool sharedGPMetaDataTool].currentDistrict;
    };
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
