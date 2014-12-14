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
#import "GPCover.h"
#import "GPNavigationController.h"
#import "GPDealDetailController.h"
#import "UIBarButtonItem+Addition.h"


#define kItemW 250
#define kItemH 250

#define kDetailWidth 600

@interface GPBaseDealListController ()
{
    GPCover *_cover;
}
@end

@implementation GPBaseDealListController
#pragma mark - lifecycle method
- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kItemW, kItemH); // item size
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. register cell xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    // 2. make collectionview support vertical bounce
    self.collectionView.alwaysBounceVertical = YES;
    
    // 3. set bg color
    self.collectionView.backgroundColor = kGlobalBg;
    
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
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
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

#pragma mark show detail
- (void)showDetail:(GPDeal *)deal
{
    // 1. display the overlay
    if (_cover == nil) {
        _cover = [GPCover coverWithTarget:self action:@selector(hideDetail)];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
    // 2. display deal detail controller
    GPDealDetailController *detail = [[GPDealDetailController alloc] init];
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    GPNavigationController *nav = [[GPNavigationController alloc] initWithRootViewController:detail];
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    
    // when two controllers are child and parent, their views should also be child and parent
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
}

#pragma mark hide detail
- (void)hideDetail
{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    // hide cover
    [UIView animateWithDuration:0.3 animations:^{
        // hide cover
        _cover.alpha = 0;
        
        // hide controller
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
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
