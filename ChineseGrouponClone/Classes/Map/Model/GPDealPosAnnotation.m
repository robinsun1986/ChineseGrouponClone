//
//  GPDealPosAnnotation.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/15/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealPosAnnotation.h"
#import "GPMetaDataTool.h"
#import "GPDeal.h"

@implementation GPDealPosAnnotation
- (void)setDeal:(GPDeal *)deal
{
    _deal = deal;
    
    for (NSString *c in deal.categories) {
        NSString *icon = [[GPMetaDataTool sharedGPMetaDataTool] iconWithCategoryName:c];
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            break;
        }
    }
}
@end
