//
//  GPDetailDock.h
//  ChineseGrouponClone
//
//  Created by wilson on 12/13/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDetailDockItem, GPDetailDock;

// protocol
@protocol GPDetailDockDelegate <NSObject>
@optional
- (void)detailDock:(GPDetailDock *)detailDock btnClickFrom:(int)from to:(int)to;
@end

// GPDetailDock
@interface GPDetailDock : UIView
@property (weak, nonatomic) IBOutlet GPDetailDockItem *infoBtn;
@property (weak, nonatomic) IBOutlet GPDetailDockItem *merchantBtn;
@property (weak, nonatomic) id<GPDetailDockDelegate> delegate;

- (IBAction)btnClick:(UIButton *)sender;

+ (id)detailDock;

@end

// GPDetailDockItem
@interface GPDetailDockItem : UIButton

@end