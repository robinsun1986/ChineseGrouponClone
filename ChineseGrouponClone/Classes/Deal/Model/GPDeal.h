//
//  Deal.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

@class GPRestriction;

#import <Foundation/Foundation.h>
@interface GPDeal : NSObject <NSCoding>
@property (nonatomic, copy) NSString *deal_id; // deal ID
@property (nonatomic, copy) NSString *title; // title
@property (nonatomic, copy) NSString *desc; // description
@property (nonatomic, assign) double list_price; // original price
@property (nonatomic, assign) double current_price; // current price

@property (nonatomic, copy, readonly) NSString *list_price_text; // original price text
@property (nonatomic, copy, readonly) NSString *current_price_text; // current price text

@property (nonatomic, strong) NSArray *regions; // regions
@property (nonatomic, strong) NSArray *categories; // categories
@property (nonatomic, assign) int purchase_count; // purchase count
@property (nonatomic, strong) NSString *publish_date; // publish date
@property (nonatomic, strong) NSString *purchase_deadline; // purchase dealline
@property (nonatomic, copy) NSString *image_url; // image url
@property (nonatomic, copy) NSString *s_image_url; // small image url
@property (nonatomic, copy) NSString *deal_h5_url; // link

// detail info data
@property (nonatomic, copy) NSString *details; // details
@property (nonatomic, copy) NSString *notice; // notice
@property (nonatomic, copy) GPRestriction *restrictions; // restriction

// extra properties for collect/favorite
@property (nonatomic, assign) BOOL collected; // whether its collected

@end


