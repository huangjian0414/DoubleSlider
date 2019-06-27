//
//  DoubleSliderConfig.h
//  DoubleSlider
//
//  Created by huangjian on 2019/6/26.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DoubleSliderConfig : NSObject
//左边线颜色
@property(nonatomic,strong)UIColor *leftLineColor;
//中间线颜色
@property(nonatomic,strong)UIColor *middleLineColor;
//右边线颜色
@property(nonatomic,strong)UIColor *rightLineColor;
//滑块size
@property(nonatomic,assign)CGSize sliderSize;
//左滑块颜色
@property(nonatomic,strong)UIColor *leftSliderColor;
//右滑块颜色w
@property(nonatomic,strong)UIColor *rightSliderColor;

//线的高度
@property(nonatomic,assign)CGFloat lineHeight;

//slider在view上的偏移  slider默认是居中的
@property(nonatomic,assign)CGFloat sliderOffsetY;

//slider最小值
@property(nonatomic,assign)CGFloat minValue;
//slider最大值
@property(nonatomic,assign)CGFloat maxValue;

//左边滑钮默认值
@property(nonatomic,assign)CGFloat defaultLeftValue;
//右边滑钮默认值
@property(nonatomic,assign)CGFloat defaultRightValue;

@end

NS_ASSUME_NONNULL_END
