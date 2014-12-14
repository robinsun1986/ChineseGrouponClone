//
//  GPImageTool.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/8/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPImageTool.h"
#import "UIImageView+WebCache.h"

@implementation GPImageTool
+ (void)downloadImage:(NSString *)url placeHolder:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

+ (void)clear
{
    // 1. clear all image cache in the memory
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 2. cancel all downloading requests
    [[SDWebImageManager sharedManager] cancelAll];
}
@end
