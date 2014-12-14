//
//  GPInfoHeaderView.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPInfoHeaderView.h"
#import "GPDeal.h"
#import "GPImageTool.h"
#import "NSDate+Addition.h"
#import "GPRestriction.h"
#import "UIImage+Compare.h"

@implementation GPInfoHeaderView

- (void)setDeal:(GPDeal *)deal
{
    _deal = deal;
    
    if (deal.restrictions) {
        // 2. purchase count
        NSString *purchaseCount = [NSString stringWithFormat:@"%d Sold", deal.purchase_count];
        [_purchaseCount setTitle:purchaseCount forState:UIControlStateNormal];
        
        // 4. set is_refundable
        _anyTimeBack.enabled = deal.restrictions.is_refundable;
        _expireBack.enabled = _anyTimeBack.enabled;
        
        // 5. set description
        _desc.text = deal.desc;
        CGFloat descH = [deal.desc sizeWithFont:_desc.font constrainedToSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT) lineBreakMode:_desc.lineBreakMode].height;
        CGRect descF = _desc.frame;
        CGFloat descDeltaH = descH - descF.size.height;
        descF.size.height = descH;
        _desc.frame = descF;
        
        // 6. set header height
        CGRect selfF = self.frame;
        selfF.size.height += descDeltaH;
        self.frame = selfF;
    } else {
        // 1. download image
        UIImage *placeHolder = [UIImage imageNamed:@"placeholder_deal.png"];
        [GPImageTool downloadImage:deal.image_url placeHolder:placeHolder imageView:_image];
        
        // 3. set remaining time
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *deadline = [fmt dateFromString:deal.purchase_deadline];
        deadline = [deadline dateByAddingTimeInterval:24*3600];
        NSDate *now = [NSDate date];
        
        NSDateComponents *cmps = [now compare:deadline];
        NSString *timeStr = [NSString stringWithFormat:@"%dd %dh %dm", cmps.day, cmps.hour, cmps.minute];
        [_time setTitle:timeStr forState:UIControlStateNormal];
    }
}

+ (id)infoHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GPInfoHeaderView" owner:nil options:nil][0];
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.size.height = self.frame.size.height;
//    [super setFrame:frame];
//}

@end
