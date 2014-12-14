//
//  GPDealTool.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDealTool.h"
#import "DPAPI.h"
#import "GPMetaDataTool.h"
#import "GPCity.h"
#import "GPOrder.h"
#import "GPDeal.h"
#import "NSObject+Value.h"

typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface GPDealTool () <DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}

@end

@implementation GPDealTool
singleton_implementation(GPDealTool)

- (id)init
{
    if (self = [super init]) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark get specified deal data
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error
{
    [self requestWithURL:@"v1/deal/get_single_deal" params:@{@"deal_id":ID} block:^(id result, NSError *errorObj) {
        if (result) { // success
            if (success) {
                GPDeal *deal = [[GPDeal alloc] init];
                [deal setValues:result[@"deals"][0]];
                success(deal);
            }
        } else { // failure
            if (error) {
                error(errorObj);
            }
        }
    }];
}

#pragma mark get deals data of nth page
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    // 1. config params
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(20) forKey:@"limit"];
    // 1.1. add city parameter
    NSString *city = [GPMetaDataTool sharedGPMetaDataTool].currentCity.name;
    params[@"city"] = city;
    
    // 1.2. add district parameter
    NSString *district = [GPMetaDataTool sharedGPMetaDataTool].currentDistrict;
    if (district && ![district isEqualToString:kAllDistrict]) {
        params[@"region"] = district;
    }
    
    // 1.3. add category parameter
    NSString *category = [GPMetaDataTool sharedGPMetaDataTool].currentCategory;
    if (category && ![category isEqualToString:kAllCategory]) {
        params[@"category"] = category;
    }
    
    // 1.4. add order parameter
    GPOrder *order = [GPMetaDataTool sharedGPMetaDataTool].currentOrder;
    if (order) {
        params[@"sort"] = @(order.index);
    }
    
    // 1.5 page parameter
    params[@"page"] = @(page);
    
    // 2. send request
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObj) {
        if (errorObj) {
            if (error) {
                error(errorObj);
            }
        } else if (success) {
            NSArray *arr = result[@"deals"];
            NSMutableArray *deals = [NSMutableArray array];
            for (NSDictionary *dict in arr) {
                GPDeal *d = [[GPDeal alloc] init];
                [d setValues:dict];
                [deals addObject:d];
            }
            
            success(deals, [result[@"total_count"] intValue]);
        }
    }];
}

- (void)requestWithURL:(NSString *)url params:(NSDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    // one request, one block
    _blocks[request.description] = block;
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
}
@end






