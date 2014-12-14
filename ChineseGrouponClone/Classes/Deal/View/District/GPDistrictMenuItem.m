//
//  GPDistrictMenuItem.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/6/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPDistrictMenuItem.h"
#import "GPDistrict.h"

@implementation GPDistrictMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDistrict:(GPDistrict *)district
{
    _district = district;
    [self setTitle:district.name forState:UIControlStateNormal];
}

- (NSArray *)titles
{
    return _district.neighborhoods;
}

@end
