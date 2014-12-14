//
//  UIImage+Compare.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compare)
+ (BOOL)compareBetween:(UIImage *)image1 and:(UIImage *)image2;
- (BOOL)compare:(UIImage *)other;
@end
