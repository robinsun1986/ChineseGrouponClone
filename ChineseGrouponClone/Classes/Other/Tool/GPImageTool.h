//
//  GPImageTool.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPImageTool : NSObject
+ (void)downloadImage:(NSString *)url placeHolder:(UIImage *)place imageView:(UIImageView *)imageView;
+ (void)clear;
@end
