//
//  UIImage+Compare.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "UIImage+Compare.h"

@implementation UIImage (Compare)

+ (BOOL)compareBetween:(UIImage *)image1 and:(UIImage *)image2
{
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqual:data2];
}

- (BOOL)compare:(UIImage *)other
{
    return [UIImage compareBetween:self and:other];
}

@end
