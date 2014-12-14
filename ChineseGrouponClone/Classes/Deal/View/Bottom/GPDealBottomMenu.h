//
//  GPDealBottomMenu.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPSubtitlesView, GPDealBottomMenuItem;
@interface GPDealBottomMenu : UIView
{
    UIScrollView *_scrollView;
    GPSubtitlesView *_subtitlesView;
    GPDealBottomMenuItem *_selectedItem;
}
@property (nonatomic, copy) void (^hideBlock)();

// show with animation
- (void)show;
// hide with animation
- (void)hide;

- (void)settingSubtitlesView;
@end
