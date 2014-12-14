//
//  GPSubtitlesView.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSubtitlesView : UIImageView
@property (nonatomic, copy) NSString *mainTitle; // main title
@property (nonatomic, strong) NSArray *titles; // all titles
@property (nonatomic, copy) void (^setTitleBlock)(NSString *title);
@property (nonatomic, copy) NSString * (^getTitleBlock)();

// show with animation
- (void)show;
// hide with animation
- (void)hide;
@end
