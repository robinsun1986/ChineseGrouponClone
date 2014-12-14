//
//  GPDock.h
//  ChineseGrouponClone
//
//  Created by wilson on 11/20/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDock;
@protocol GPDockDelegate <NSObject>
@optional
-(void)dock:(GPDock *)dock tabChangeFrom:(int)from to:(int)to;
@end

@interface GPDock : UIView
@property (nonatomic, weak) id<GPDockDelegate> delegate;
@end
