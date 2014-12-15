//
//  GPDealPosAnnotation.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/15/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <MapKit/MapKit.h>

@class GPDeal, GPBusiness;
@interface GPDealPosAnnotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) GPDeal *deal;
@property (nonatomic, strong) GPBusiness *business;
@property (nonatomic, copy) NSString *icon;
@end
