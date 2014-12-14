//
//  GPInfoTextView.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPInfoTextView.h"

@implementation GPInfoTextView

+ (id)infoTextView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GPInfoTextView" owner:nil options:nil][0];
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleView setTitle:title forState:UIControlStateNormal];;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    // 1. set label text
    _contentView.text = content;
    
    // 2. calculate text height
    CGFloat textH = [content sizeWithFont:_contentView.font constrainedToSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) lineBreakMode:_contentView.lineBreakMode].height;
    CGRect contentF = _contentView.frame;
    CGFloat contentDelta = textH - contentF.size.height;
    contentF.size.height = textH;
    _contentView.frame = contentF;
    
     // 3. adjust the height of the cotent view
    CGRect selfF = self.frame;
    selfF.size.height += contentDelta;
    self.frame = selfF;
}

@end





