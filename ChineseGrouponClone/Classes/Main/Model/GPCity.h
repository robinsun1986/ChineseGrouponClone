//
//  GPCity.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPBaseModel.h"

@interface GPCity : GPBaseModel
@property (nonatomic, strong) NSArray *districts;
@property (nonatomic, assign) BOOL hot;
@end
