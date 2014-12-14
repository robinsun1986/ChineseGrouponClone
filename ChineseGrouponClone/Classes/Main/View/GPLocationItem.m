//
//  GPLocationItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPLocationItem.h"
#import "GPCityListController.h"
#import "GPMetaDataTool.h"
#import "GPCity.h"

#define kImageScale 0.5

@interface GPLocationItem () <UIPopoverControllerDelegate>
{
    UIPopoverController *_popover;
}
@end

@implementation GPLocationItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // set internal picture
        [self setIcon:@"ic_district.png" selectedIcon:@"ic_district_hl.png"];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self setTitle:@"Location" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        // set image property
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchDown];
        
        // observe city change notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    }
    return self;
}

- (void)screenRotate
{
    MyLog(@"Screen rotate");
    
    if ([_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:NO];

        // display the popover after 0.5 sec
        [self performSelector:@selector(showPopover) withObject:nil afterDelay:0.5];
    }
}

- (void)showPopover
{
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)cityChange
{
    MyLog(@"city change");
    
    GPCity *city = [GPMetaDataTool sharedGPMetaDataTool].currentCity;
    
    // 1. change city title
    [self setTitle:city.name forState:UIControlStateNormal];
    
    // 2. close popover
    [_popover dismissPopoverAnimated:YES];
    
    // 3. change to enable
    self.enabled = YES;
}

- (void)locationClick
{
    GPCityListController *city = [[GPCityListController alloc] init];
    city.view.backgroundColor = [UIColor redColor];
    _popover = [[UIPopoverController alloc] initWithContentViewController:city];
    _popover.popoverContentSize = CGSizeMake(320, 480);
    _popover.delegate = self;
    [self showPopover];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    // observe screen rotate notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark remove the observer when the popover is dismissed
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// notification must be removed in dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * kImageScale;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * (1 - kImageScale);
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, w, h);
}

@end
