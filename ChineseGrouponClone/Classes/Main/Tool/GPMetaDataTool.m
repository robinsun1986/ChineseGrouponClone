//
//  GPMetaDataTool.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPMetaDataTool.h"
#import "GPCitySection.h"
#import "NSObject+Value.h"
#import "GPCity.h"
#import "GPCategory.h"
#import "GPOrder.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface GPMetaDataTool ()
{
    NSMutableArray *_visitedCityNames;
    //NSMutableDictionary *_totalCities; // key: city name, value: city object
    GPCitySection *_visitedSection;
}
@end

@implementation GPMetaDataTool

singleton_implementation(GPMetaDataTool)

- (id)init
{
    if (self = [super init]) {
        // 1. load city data
        [self loadCityData];
        // 2. load category data
        [self loadCategoryData];
        // 3. load sorting data
        [self loadOrderData];
    }
    
    return self;
}

#pragma mark load city data
- (void)loadCityData
{
    // store all cities
    _totalCities = [NSMutableDictionary dictionary];
    NSMutableArray *tempSections = [NSMutableArray array];
    
    // 1. add hot city sections
    GPCitySection *hotSection = [[GPCitySection alloc] init];
    hotSection.name = @"Hot Cities";
    hotSection.cities = [NSMutableArray array];;
    [tempSections addObject:hotSection];
    
    // 2. add A-Z array
    // initialize all meta data
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    for (NSDictionary *dict in array) {
        GPCitySection *section = [[GPCitySection alloc] init];
        [section setValues:dict];
        [tempSections addObject:section];
        
        for (GPCity *city in section.cities) {
            if (city.hot) {
                //NSLog(@"%@", city.name);
                [hotSection.cities addObject:city];
            }
            
            _totalCities[city.name] = city;
        }
    }
    
    // 3. retrieve the names of the visited cities from sandbox
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    //MyLog(@"%@", _visitedCityNames);
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 4. add recent visited city section
    _visitedSection = [[GPCitySection alloc] init];
    _visitedSection.name = @"Recent Visit";
    _visitedSection.cities = [NSMutableArray array];
    
    if (_visitedCityNames.count > 0) {
        [tempSections insertObject:_visitedSection atIndex:0];
    }
    
    for (NSString *name in _visitedCityNames) {
        GPCity *city = _totalCities[name];
        [_visitedSection.cities addObject:city];
    }
    
    _totalCitySections = tempSections;
}

#pragma mark load category data
- (void)loadCategoryData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    NSMutableArray *temp = [NSMutableArray array];
    
    // 1. add all categories
    GPCategory *all = [[GPCategory alloc] init];
    all.name = kAllCategory;
    all.icon = @"ic_filter_category_-1.png";
    [temp addObject:all];
    
    for (NSDictionary *dict in array) {
        GPCategory *c = [[GPCategory alloc] init];
        [c setValues:dict];
        [temp addObject:c];
    }
    
    _totalCategories = temp;
}

#pragma mark load order data
- (void)loadOrderData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders.plist" ofType:nil]];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        GPOrder *o = [[GPOrder alloc] init];
        o.name = array[i];
        o.index = i + 1;
        [temp addObject:o];
    }
    
    _totalOrders = temp;
}

- (void)setCurrentCity:(GPCity *)currentCity
{
    //BOOL cityChanged = (_currentCity != currentCity);
    _currentCity = currentCity;
    
    // change the current selected district
    _currentDistrict = kAllDistrict;
    
    // 1. remove duplicated city names
    [_visitedCityNames removeObject:currentCity.name];
    [_visitedSection.cities removeObject:currentCity];
    
    // 2. add the current city name to the head of the array
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    // 3. add the current city to the head of the array
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];

    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    // add recent visited city
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}

- (void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil];
}

- (void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict = currentDistrict;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil];
}

- (void)setCurrentOrder:(GPOrder *)currentOrder
{
    _currentOrder = currentOrder;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil];
}

- (GPOrder *)orderWithName:(NSString *)name
{
    for (GPOrder *order in _totalOrders) {
        if ([order.name isEqualToString:name]) {
            return order;
        }
    }
    
    return nil;
}

#pragma mark get icon by category name
- (NSString *)iconWithCategoryName:(NSString *)name
{
    for (GPCategory *c in _totalCategories) {
        if ([c.name isEqualToString:name] || [c.subcategories containsObject:name]) return c.icon;
    }
    
    return nil;
}

@end
