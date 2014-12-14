//
//  UIBarButtonItem+Addition.h
//  ChineseTwitterClone
//
//  Created by wilson on 8/28/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addition)

- (id)initwithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

@end
