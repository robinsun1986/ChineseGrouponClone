//
//  GPBusiness.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/15/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPBusiness : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;
@end
