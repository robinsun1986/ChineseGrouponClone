//
//  GPCollectTool.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCollectTool.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collects.data"]

@interface GPCollectTool ()
{
    NSMutableArray *_collectedDeals;
}
@end

@implementation GPCollectTool
singleton_implementation(GPCollectTool)

- (instancetype)init
{
    if (self = [super init]) {
        // 1. load collection data in sandbox
        _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        // 2. initialize array if empty
        if (_collectedDeals == nil) {
            _collectedDeals = [NSMutableArray array];
        }
    }
    
    return self;
}

- (void)handleDeal:(GPDeal *)deal
{
    deal.collected = [_collectedDeals containsObject:deal];
}

- (void)collectDeal:(GPDeal *)deal
{
    deal.collected = YES;
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

- (void)uncollectDeal:(GPDeal *)deal
{
    deal.collected = NO;
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

@end
