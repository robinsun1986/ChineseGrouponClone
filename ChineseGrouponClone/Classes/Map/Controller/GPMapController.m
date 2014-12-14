//
//  GPMapController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPMapController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GPMapController () <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
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
}

#pragma mark - mapview delegate
#pragma mark called when user location is enabled
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MyLog(@"didUpdateUserLocation");
    if (_mapView) return;
    
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    _mapView = mapView;
}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    MyLog(@"%f, %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
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



