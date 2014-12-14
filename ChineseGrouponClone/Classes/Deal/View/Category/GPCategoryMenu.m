//
//  GPCategoryMenu.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCategoryMenu.h"
#import "GPMetaDataTool.h"
#import "GPCategoryMenuItem.h"
#import "GPMetaDataTool.h"

#import "GPSubtitlesView.h"

@interface GPCategoryMenu ()
{
   
}
@end

@implementation GPCategoryMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *categories = [GPMetaDataTool sharedGPMetaDataTool].totalCategories;
        
        // 1. add content to scroll view
        int count = categories.count;
        for (int i=0; i<count; i++) {
            GPCategoryMenuItem *item = [[GPCategoryMenuItem alloc] init];
            item.category = categories[i];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
            
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}

- (void)settingSubtitlesView
{    
    _subtitlesView.setTitleBlock = ^(NSString *title) {
        [GPMetaDataTool sharedGPMetaDataTool].currentCategory = title;
    };
    
    _subtitlesView.getTitleBlock = ^{
        return [GPMetaDataTool sharedGPMetaDataTool].currentCategory;
    };
}

@end









