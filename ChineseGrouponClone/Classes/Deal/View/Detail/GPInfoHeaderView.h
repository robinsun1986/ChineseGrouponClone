//
//  GPInfoHeaderView.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPRoundRectView.h"

@class GPDeal;
@interface GPInfoHeaderView : GPRoundRectView

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeBack;
@property (weak, nonatomic) IBOutlet UIButton *expireBack;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

@property (nonatomic, strong) GPDeal *deal;
+ (id)infoHeaderView;
@end
