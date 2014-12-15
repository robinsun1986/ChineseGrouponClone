//
//  GPMapController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GPMapController.h"
#import "GPDealTool.h"
#import "GPDealPosAnnotation.h"
#import "GPDeal.h"
#import "GPBusiness.h"
#import "GPMetaDataTool.h"

#define kSpan MKCoordinateSpanMake(0.018404, 0.031468)

@interface GPMapController () <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    NSMutableArray *_showingDeals;
}
@end

@implementation GPMapController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Map";
    
    // 1. add map
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    if(IS_OS_8_OR_LATER) {
//        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//            [_locationManager requestWhenInUseAuthorization];
//        }
//       
//        //[_locationManager requestAlwaysAuthorization];
//    }
//    [_locationManager startUpdatingLocation];
    
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    // 2. init array
    _showingDeals = [NSMutableArray array];
    
    // 3. add a button (back to current position)
    UIButton *backUser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backUser setTitle:@"Back to current position" forState:UIControlStateNormal];
    CGFloat w = 200;
    CGFloat h = 40;
    CGFloat x = self.view.frame.size.width - w - 20;
    CGFloat y = self.view.frame.size.height - h - 20;
    backUser.frame = CGRectMake(x, y, w, h);
    backUser.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [backUser addTarget:self action:@selector(backUserClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUser];
}

- (void)backUserClick
{
    CLLocationCoordinate2D center = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    [_mapView setRegion:region animated:YES];
}

#pragma mark - mapview delegate
#pragma mark called when user location is enabled
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MyLog(@"didUpdateUserLocation");
    if (_mapView) return;
    
    // 1. location
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 2. span(range)
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    // 3. region
    [mapView setRegion:region animated:YES];
    
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    _mapView = mapView;
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    MyLog(@"%f, %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
    
    // 1. center position of the current map
    CLLocationCoordinate2D pos = mapView.region.center;
    
//    MyLog(@"%f, %f", pos.latitude, pos.longitude);
    
    [[GPDealTool sharedGPDealTool] dealWithPos:pos success:^(NSArray *deals, int totalCount) {
        for (GPDeal *d in deals) {
            // avoid adding annotation for the same business repeatedly
            if ([_showingDeals containsObject:d]) continue;
            
            [_showingDeals addObject:d];
            
            for (GPBusiness *b in d.businesses) {
                GPDealPosAnnotation *annotation = [[GPDealPosAnnotation alloc] init];
                annotation.business = b;
                annotation.deal = d;
                annotation.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:annotation];
            }
        }
    } error:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(GPDealPosAnnotation *)annotation
{
    if (![annotation isKindOfClass:[GPDealPosAnnotation class]]) return nil;
    
    // 1. get annotation view from buffer pool
    static NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    // 2. create a new annotation if no reusable one
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    // 3. set annotation view
    annotationView.annotation = annotation;
    // 4. set image
    annotationView.image = [UIImage imageNamed:annotation.icon];

    return annotationView;
}

#pragma mark annotation clicked
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    GPDealPosAnnotation *annotation = view.annotation;
    [self showDetail:annotation.deal];
}



//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *newLocation = [locations lastObject];
//    MyLog(@"%@", newLocation);
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    MyLog(@"%@", error);
//}
//
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    MyLog(@"%d", status);
//}

@end



