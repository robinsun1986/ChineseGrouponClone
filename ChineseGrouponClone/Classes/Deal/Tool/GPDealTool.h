//
//  GPDealTool.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <MapKit/MapKit.h>

@class GPDeal;
// deals contain all model data
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

typedef void (^DealSuccessBlock)(GPDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);

@interface GPDealTool : NSObject
singleton_interface(GPDealTool)

#pragma mark get deals of the nth page
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
#pragma mark get specified deals
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;
#pragma mark get the nearby deals
- (void)dealWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

@end
