//
//  GPCover.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/9/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPCover : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;
- (void)reset;
@end
