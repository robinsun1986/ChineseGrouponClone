//
//  GPRestriction.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPRestriction : NSObject
@property (nonatomic, assign) BOOL is_reservation_required; // 0: no, 1: yes
@property (nonatomic, assign) BOOL is_refundable; // 0: no, 1: yes
@property (nonatomic, copy) NSString *special_tips; // special tips
@end
