//
//  GPBuyDock.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPBuyDock.h"
#import "GPDeal.h"
#import "UIImage+Addition.h"
#import "GPCenterLineLabel.h"

@implementation GPBuyDock

- (void)setDeal:(GPDeal *)deal
{
    _deal = deal;
    
    _listPrice.text = [NSString stringWithFormat:@"%@ 元", deal.list_price_text];
    _currentPrice.text = deal.current_price_text;
}

+ (id)buyDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"GPBuyDock" owner:nil options:nil][0];
}

// enable a semi-transparent background
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}

@end
