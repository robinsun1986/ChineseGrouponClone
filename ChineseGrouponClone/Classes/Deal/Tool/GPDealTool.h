//
//  GPDealTool.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class GPDeal;
// deals contain all model data
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);


typedef void (^DealSuccessBlock)(GPDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);

@interface GPDealTool : NSObject
singleton_interface(GPDealTool)
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;
@end
