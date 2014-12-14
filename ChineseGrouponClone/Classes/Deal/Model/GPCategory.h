//
//  GPCategory.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/5/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPBaseModel.h"

@interface GPCategory : GPBaseModel
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *subcategories;
@end
