//
//  UIView+HJViewFrame.h
//
//  Created by huangjian on 16/4/19.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HJViewFrame)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;

@property (assign, nonatomic) CGFloat maxX;
@property (assign, nonatomic) CGFloat maxY;
-(void)setAddX:(CGFloat)addX;
-(void)setAddY:(CGFloat)addY;


@end
