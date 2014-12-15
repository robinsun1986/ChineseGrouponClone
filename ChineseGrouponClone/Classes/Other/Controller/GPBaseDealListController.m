//
//  GPBaseDealListController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPBaseDealListController.h"
#import "GPDeal.h"
#import "GPDealCell.h"

#define kItemW 250
#define kItemH 250

@interface GPBaseDealListController () <UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation GPBaseDealListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0. create custom collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kItemW, kItemH); // item size
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    // 1. register cell xib
    [_collectionView registerNib:[UINib nibWithNibName:@"GPDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    // 2. make collectionview support vertical bounce
    _collectionView.alwaysBounceVertical = YES;
    
    // 3. set bg color
    _collectionView.backgroundColor = kGlobalBg;
    
}

// viewDidLoad will regard the smallest side as the width,
// and the largest side as height, use viewWillAppear to get the precise width and height
- (void)viewWillAppear:(BOOL)animated
{
    // calculate the layout by default
    [self didRotateFromInterfaceOrientation:0];
}

// to be implemented by subclass
- (NSArray *)totalDeals
{
    return nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark called when the screen will rotate (only for UIViewController), use layoutSubviews in UIView
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//
//}

#pragma mark called when screen rotation is finished
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    
    CGFloat h = 0;
    CGFloat v = 20;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        h = (self.view.frame.size.width - 3 * kItemW) / 4;
    } else {
        h = (self.view.frame.size.width - 2 * kItemW) / 3;
    }
    
    layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:self.totalDeals[indexPath.row]];
}

#pragma mark - DPRequestDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalDeals.count;
}

#pragma mark called when reloadData is called or
#pragma mark when a new cell enter the screen
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"deal";
    GPDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.deal = self.totalDeals[indexPath.row];
    return cell;
}



@end
