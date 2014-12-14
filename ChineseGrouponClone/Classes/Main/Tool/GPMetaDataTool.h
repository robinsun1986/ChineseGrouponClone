//
//  GPMetaDataTool.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//  Meta Data Tool
//  1. city data
//  2. district data

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class GPCity, GPOrder;

@interface GPMetaDataTool : NSObject
singleton_interface(GPMetaDataTool)
@property (nonatomic, strong, readonly) NSMutableDictionary *totalCities;
@property (nonatomic, strong, readonly) NSArray *totalCitySections;

@property (nonatomic, strong, readonly) NSArray *totalCategories;

// all sorting data
@property (nonatomic, strong, readonly) NSArray *totalOrders;

@property (nonatomic, strong) GPCity *currentCity;
@property (nonatomic, copy) NSString *currentCategory;
@property (nonatomic, copy) NSString *currentDistrict;
@property (nonatomic, strong) GPOrder *currentOrder;

- (GPOrder *)orderWithName:(NSString *)name;

@end
