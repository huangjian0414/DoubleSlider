//
//  DoubleSlider.h
//  DoubleSlider
//
//  Created by huangjian on 2019/6/26.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubleSliderConfig.h"
NS_ASSUME_NONNULL_BEGIN

//返回左边的值，右边的值，左边按钮的中心，右边按钮的中心
typedef void(^PanResponse)(CGFloat leftValue, CGFloat rightValue, CGPoint leftCenter, CGPoint rightCenter);
@interface DoubleSlider : UIView
//slider 配置
@property(nonatomic,strong)DoubleSliderConfig *config;

@property(nonatomic,copy)PanResponse panResponse;
@end

NS_ASSUME_NONNULL_END
