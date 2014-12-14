//
//  GPCollectController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCollectController.h"
#import "GPCollectTool.h"

@interface GPCollectController ()

@end

@implementation GPCollectController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Collection";
    
    [[NSNotificationCenter defaultCenter] addObserver:self.collectionView selector:@selector(reloadData) name:kCollectChangeNote object:nil];
}

- (NSArray *)totalDeals
{
    return [GPCollectTool sharedGPCollectTool].collectedDeals;
}

@end
