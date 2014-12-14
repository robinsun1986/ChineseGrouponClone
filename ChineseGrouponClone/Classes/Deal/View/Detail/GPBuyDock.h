//
//  GPBuyDock.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPDeal, GPCenterLineLabel;
@interface GPBuyDock : UIView
@property (weak, nonatomic) IBOutlet GPCenterLineLabel *listPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;

@property (nonatomic, strong) GPDeal *deal;

+ (id)buyDock;

@end
