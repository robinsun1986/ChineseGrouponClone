//
//  GPSubtitlesView.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPSubtitlesView.h"
#import "UIImage+Addition.h"
#import "GPMetaDataTool.h"

#define kTitleW 100
#define kTitleH 40

#define kDuration 1.0

@interface GPSubtitlesView ()
{
    UIButton *_selectedBtn;
}
@end

@implementation GPSubtitlesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
        // make sure the bounds of subview does not exceed that of superview
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark click event of one subtitles item
- (void)titleClick:(UIButton *)btn
{
    // 1. set control state
    _selectedBtn.selected = NO;
    _selectedBtn = btn;
    _selectedBtn.selected = YES;
    
    // 2. set the selected category
    if (_setTitleBlock) {
        NSString *title = [btn titleForState:UIControlStateNormal];
        if ([title isEqualToString:kAll]) {
            title = _mainTitle;
        }
        _setTitleBlock(title);
    }
    
//    MyLog(@"%@ - %@", [GPMetaDataTool sharedGPMetaDataTool].currentCategory, [GPMetaDataTool sharedGPMetaDataTool].currentDistrict);
}

- (void)setTitles:(NSArray *)titles
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kAll];
    [array addObjectsFromArray:titles];
    _titles = array;
    
    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int columns = self.frame.size.width / kTitleW;
    
    int count = _titles.count;
    // set button title
    for (int i=0; i<count; i++) {

        // 1. get the button
        UIButton *btn = nil;
        if (i >= self.subviews.count) { // create a button corresponding to the index
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [self addSubview:btn];
        } else { // reuse the existing button
            btn = self.subviews[i];
        }
        
        // 2. set title
        btn.hidden = NO;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        
        if (_getTitleBlock) {
            NSString *current = _getTitleBlock();
            
            // if main title is selected, select the first button("All")
            if ([current isEqualToString:_mainTitle] && i == 0) {
                btn.selected = YES;
                _selectedBtn = btn;
            } else {
                btn.selected = [_titles[i] isEqualToString:current];
                if (btn.selected) {
                    _selectedBtn = btn;
                }
            }

        } else {
            btn.selected = NO;
        }
        
        // 3. set position
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
    // hide extra button
    for (int i = count; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
    
    [self layoutSubviews];
}

// called when width and height of this view are changed
- (void)layoutSubviews
{
    // super method must be called
    [super layoutSubviews];
    
    int columns = self.frame.size.width / kTitleW;
    for (int i=0; i<_titles.count; i++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
    int rows = (_titles.count + columns - 1) / columns;
    CGRect frame = self.frame;
    frame.size.height = rows * kTitleH;
    self.frame = frame;
}

#pragma mark display
- (void)show
{
    [self layoutSubviews];
    
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1. scroll view move up
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        
        // 2. overlay (0.4 -> 0)
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

@end






