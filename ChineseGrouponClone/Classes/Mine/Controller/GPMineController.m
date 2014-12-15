//
//  GPMineController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPMineController.h"
#import "GPDealTool.h"

@interface GPMineController ()

@end

@implementation GPMineController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Mine";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
    
}

- (void)logout
{
//    [[GPDealTool sharedGPDealTool] dealsWithPage:1 success:^(NSArray *deals, int totalCount) {
//        [self showDetail:deals[0]];
//    } error:nil];
}

@end
