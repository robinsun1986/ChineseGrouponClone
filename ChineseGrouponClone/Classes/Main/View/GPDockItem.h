//
//  GPDockItem.h
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPDockItem : UIButton

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, strong) UIImageView *divider;

- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;

@end
