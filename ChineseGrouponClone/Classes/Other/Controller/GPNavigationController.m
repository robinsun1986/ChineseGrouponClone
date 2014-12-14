//
//  GPNavigationController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPNavigationController.h"
#import "UIImage+Addition.h"

@interface GPNavigationController ()

@end

@implementation GPNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
        self.navigationBar.translucent = NO;
    }
}

#pragma mark initialize is called the first time the class is used
+ (void)initialize
{
    // 1. all navigation bars across the app - [UINavigationBar appearance], ios 5+
    UINavigationBar *bar = [UINavigationBar appearance];
    // 2. set bg image for navigation bar
    [bar setBackgroundImage:[UIImage resizedImage:@"bg_navigation.png"] forBarMetrics:UIBarMetricsDefault];
    // 3. set text attributes for navigation bar
    [bar setTitleTextAttributes:@{
       UITextAttributeTextColor: [UIColor blackColor],
     // OC collection(array, map) can contain only OC objects, not struct
UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]
     }];
    
    // 4. Change the appearance of all UIBarButtonItem
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"bg_navigation_right.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"bg_navigation_right_hl.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    NSDictionary *dict = @{
                           UITextAttributeTextColor: [UIColor grayColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           UITextAttributeFont: [UIFont systemFontOfSize:16]
                           };
    // change text attributes on bar button item
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

@end
