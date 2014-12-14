//
//  GPDealCell.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealCell.h"
#import "GPDeal.h"
#import "GPImageTool.h"
#import "NSString+Double.h"

@implementation GPDealCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDeal:(GPDeal *)deal
{
    _deal = deal;
    
    // 1. set description
    _desc.text = deal.desc;
    
    // 2. download image
    [GPImageTool downloadImage:deal.image_url placeHolder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    
    // 3. purchase count
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d", deal.purchase_count] forState:UIControlStateNormal];
    
    // 4. price
    _price.text = deal.current_price_text;
    
    
    // 5. badge
    // 5.1 get the current time string
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate:[NSDate date]];
    // 5.2 compare the current time
    NSString *icon = nil;
    if ([deal.publish_date isEqualToString:now]) {
        icon = @"ic_deal_new.png";
    } else if ([deal.purchase_deadline isEqualToString:now]) {
        icon = @"ic_deal_soonOver.png";
    } else if ([deal.purchase_deadline compare:now] == NSOrderedAscending) {
        icon = @"ic_deal_over.png";
    } 
    
    _badge.hidden = (icon == nil);
    _badge.image = [UIImage imageNamed:icon];
}

@end
