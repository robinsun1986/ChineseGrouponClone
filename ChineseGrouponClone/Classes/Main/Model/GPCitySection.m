//
//  GPCitySection.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCitySection.h"
#import "GPCity.h"
#import "NSObject+Value.h"

@implementation GPCitySection
- (void)setCities:(NSMutableArray *)cities
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in cities) {
        if (![dict isKindOfClass:[NSDictionary class]]) {
            _cities = cities;
            return;
        }
        
        GPCity *city = [[GPCity alloc] init];
        [city setValues:dict];
        [array addObject:city];
    }
    
    _cities = array;
}
@end
