//
//  GPCollectTool.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "GPDeal.h"

@interface GPCollectTool : NSObject
singleton_interface(GPCollectTool)

// get all collected deals
@property (nonatomic, strong, readonly) NSArray *collectedDeals;

// handle whether to collect a deal
- (void)handleDeal:(GPDeal *)deal;

// add collection
- (void)collectDeal:(GPDeal *)deal;
// cancel collection
- (void)uncollectDeal:(GPDeal *)deal;

@end
