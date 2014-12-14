//
//  GPOrderMenu.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPOrderMenu.h"
#import "GPMetaDataTool.h"
#import "GPOrderMenuItem.h"

@implementation GPOrderMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. add contents to UIScrollView
        NSArray *orders = [GPMetaDataTool sharedGPMetaDataTool].totalOrders;
        int count = orders.count;
        
        for (int i=0; i<count; i++) {
            // create district menu item
            GPOrderMenuItem *item = [[GPOrderMenuItem alloc] init];
            item.order = orders[i];
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

@end
