//
//  GPMineController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPMineController.h"

@interface GPMineController ()

@end

@implementation GPMineController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Mine";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
}


@end
