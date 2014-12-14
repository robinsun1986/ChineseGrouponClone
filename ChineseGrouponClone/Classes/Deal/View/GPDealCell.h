//
//  GPDealCell.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDeal;
@interface GPDealCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
@property (weak, nonatomic) IBOutlet UIImageView *badge;

@property (nonatomic, strong) GPDeal *deal;
@end
