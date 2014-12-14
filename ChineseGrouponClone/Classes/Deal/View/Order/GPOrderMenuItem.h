//
//  GPOrderMenuItem.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealBottomMenuItem.h"

@class GPOrder;
@interface GPOrderMenuItem : GPDealBottomMenuItem
@property (nonatomic, strong) GPOrder *order;
@end
