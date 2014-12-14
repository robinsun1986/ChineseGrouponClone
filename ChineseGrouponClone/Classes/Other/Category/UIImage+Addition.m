//
//  UIImage+Addition.m
//  ChineseTwitterClone
//
//  Created by wilson on 8/27/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "UIImage+Addition.h"
#import "NSString+Addition.h"

@implementation UIImage (Addition)

#pragma mark load full screen image
+ (UIImage *)fullScreenImage:(NSString *)imgName
{
    // 1. if it is iPhone5,
    if (iPhone5) {
        imgName = [imgName fileAppend:@"-568h@2x"];
    }
    
    return [self imageNamed:imgName];
}

#pragma mark get streched image
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

#pragma mark get streched image
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    // deprecated
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
    //    // new since ios5.0+
    //    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    //    // new since ios6.0+
    //    [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
}

@end
