//
//  GPDetailDock.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDetailDock.h"


@interface GPDetailDock ()
{
    UIButton *_selectedBtn;
}
@end

@implementation GPDetailDock

// set fixed frame size (always identical to the previous frame)
- (void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

#pragma mark tab button click
- (IBAction)btnClick:(UIButton *)sender {
    // notify delegate
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)]) {
        [_delegate detailDock:self btnClickFrom:_selectedBtn.tag to:sender.tag];
    }
    
    // 1. change button state
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    // 2. add the clicked button on the top
    if (sender == _infoBtn) {
        [self insertSubview:_merchantBtn atIndex:0];
    } else if (sender == _merchantBtn) {
        [self insertSubview:_infoBtn atIndex:0];
    }
    [self bringSubviewToFront:sender];
}

+ (id)detailDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"GPDetailDock" owner:nil options:nil][0];
}

- (void)awakeFromNib
{
    [self btnClick:_infoBtn];
}

@end

@implementation GPDetailDockItem

- (void)setHighlighted:(BOOL)highlighted
{
}

@end


