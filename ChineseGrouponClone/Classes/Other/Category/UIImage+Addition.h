//
//  UIImage+Addition.h
//  ChineseTwitterClone
//
//  Created by wilson on 8/27/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

#pragma mark load full screen image
+ (UIImage *)fullScreenImage:(NSString *)imgName;

#pragma mark get streched image
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark get streched image
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

@end
