//
//  GPBaseDealListController.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPBaseShowDetailController.h"

@interface GPBaseDealListController : GPBaseShowDetailController
{
    UICollectionView *_collectionView;
}
- (NSArray *)totalDeals;
@end
