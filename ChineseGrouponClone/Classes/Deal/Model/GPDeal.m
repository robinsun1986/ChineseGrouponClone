//
//  Deal.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDeal.h"
#import "NSString+Double.h"
#import "GPRestriction.h"
#import "NSObject+Value.h"
#import "GPBusiness.h"

@implementation GPDeal

- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:_current_price decimal:2];
}

- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    
    _list_price_text = [NSString stringWithDouble:_list_price decimal:2];
}

- (void)setRestrictions:(GPRestriction *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[GPRestriction alloc] init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    } else {
        _restrictions = restrictions;
    }
}

- (void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            GPBusiness *b = [[GPBusiness alloc] init];
            [b setValues:dict];
            [temp addObject:b];
        }
        _businesses = temp;
        
    } else {
        _businesses = businesses;
    }
}

- (BOOL)isEqual:(GPDeal *)other
{
    return [self.deal_id isEqualToString:other.deal_id];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    [aCoder encodeObject:_deal_id forKey:@"_deal_id"];
    [aCoder encodeObject:_image_url forKey:@"_image_url"];
    [aCoder encodeObject:_desc forKey:@"_desc"];
    [aCoder encodeDouble:_current_price forKey:@"_current_price"];
    [aCoder encodeInt:_purchase_count forKey:@"_purchase_count"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.purchase_deadline = [aDecoder decodeObjectForKey:@"_purchase_deadline"];
        self.deal_id = [aDecoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [aDecoder decodeObjectForKey:@"_image_url"];
        self.desc = [aDecoder decodeObjectForKey:@"_desc"];
        self.current_price = [aDecoder decodeDoubleForKey:@"_current_price"];
        self.purchase_count = [aDecoder decodeIntForKey:@"_purchase_count"];
    }
    return self;
}

@end





