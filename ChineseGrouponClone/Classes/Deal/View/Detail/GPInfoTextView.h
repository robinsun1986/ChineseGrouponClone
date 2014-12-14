//
//  GPInfoTextView.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/14/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPRoundRectView.h"

@interface GPInfoTextView : GPRoundRectView
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

@property (nonatomic, strong) NSString *icon; // icon
@property (nonatomic, strong) NSString *title; // title
@property (nonatomic, strong) NSString *content; // content

+ (id)infoTextView;
@end
