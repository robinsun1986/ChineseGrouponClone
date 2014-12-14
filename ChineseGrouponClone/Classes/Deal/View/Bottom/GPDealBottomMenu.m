//
//  GPDealBottomMenu.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealBottomMenu.h"
#import "GPSubtitlesView.h"
#import "GPDealBottomMenuItem.h"
#import "GPOrderMenuItem.h"
#import "GPCategoryMenuItem.h"
#import "GPDistrictMenuItem.h"
#import "GPMetaDataTool.h"
#import "GPCategoryMenuItem.h"
#import "GPDistrictMenuItem.h"
#import "GPOrderMenuItem.h"

#import "GPCover.h"

#define kDuration 0.3

@interface GPDealBottomMenu ()
{
    GPCover *_cover;
    UIView *_contentView;
}

@end

@implementation GPDealBottomMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 1. add overlay
        _cover = [GPCover coverWithTarget:self action:@selector(hide)];
        _cover.frame = self.bounds;
        [self addSubview:_cover];
        
        // 2. add scroll view
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scroll.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        scroll.backgroundColor = [UIColor whiteColor];
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        _scrollView = scroll;
        
        // 3. add to content view
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addSubview:_scrollView];
        [self addSubview:_contentView];
    }
    return self;
}

#pragma mark observe all item click
- (void)itemClick:(GPDealBottomMenuItem *)item
{
    // 1. set item state
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    // 2. check if subcategories exist
    if (item.titles.count > 0) { // display all subcategories
        [self showSubtitlesView:item];
    } else { // hide all subcategories
        [self hideSubtitlesView:item];
    }
}

#pragma mark hide subtitles view
- (void)hideSubtitlesView:(GPDealBottomMenuItem *)item
{
    // 1. hide subtitleView with animation
    [_subtitlesView hide];
    
    // 2. adjust the height of contentView
    CGRect cf = _contentView.frame;
    cf.size.height = kBottomMenuItemH;
    _contentView.frame = cf;
    
    // 3. set data
    if ([item isKindOfClass:[GPCategoryMenuItem class]]) {
        [GPMetaDataTool sharedGPMetaDataTool].currentCategory = [item titleForState:UIControlStateNormal];
    } else if ([item isKindOfClass:[GPDistrictMenuItem class]]) {
        [GPMetaDataTool sharedGPMetaDataTool].currentDistrict = [item titleForState:UIControlStateNormal];
    } else if ([item isKindOfClass:[GPOrderMenuItem class]]) {
        [GPMetaDataTool sharedGPMetaDataTool].currentOrder = [[GPMetaDataTool sharedGPMetaDataTool] orderWithName:[item titleForState:UIControlStateNormal]];
    }
}

#pragma mark show subtitles view
- (void)showSubtitlesView:(GPDealBottomMenuItem *)item
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kDefaultAnimDuration];
    
    if (_subtitlesView == nil) {
        _subtitlesView = [[GPSubtitlesView alloc] init];
        
        [self settingSubtitlesView];
    }

    _subtitlesView.frame = CGRectMake(0, kBottomMenuItemH, self.frame.size.width, _subtitlesView.frame.size.height);
    // set main title property for subtitlesview
    _subtitlesView.mainTitle = [item titleForState:UIControlStateNormal];
    _subtitlesView.titles = item.titles;
    
    if (_subtitlesView.superview == nil) { // no super view for subtitle view
        [_subtitlesView show];
    }
    
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    
    // adjust the height of contentview, otherwise any click on the subtitlesView
    // would cause the hide of contentView
    CGRect cf = _contentView.frame;
    cf.size.height = CGRectGetMaxY(_subtitlesView.frame);
    _contentView.frame = cf;
    
    [UIView commitAnimations];
}

#pragma mark display
- (void)show
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1. scroll view move down
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        // 2. overlay reset
        [_cover reset];
    }];
}

- (void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1. scroll view move up 
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        _contentView.alpha = 0;
        
        // 2. overlay (0.4 -> 0)
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        [_cover reset];
    }];
}

#pragma mark empty implementation in super class
- (void)settingSubtitlesView
{
}
@end
