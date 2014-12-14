//
//  GPCity.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCity.h"
#import "GPDistrict.h"
#import "NSObject+Value.h"

@implementation GPCity
- (void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in districts) {
        GPDistrict *district = [[GPDistrict alloc] init];
        [district setValues:dict];
        [array addObject:district];
    }
    
    _districts = array;
}
@end
