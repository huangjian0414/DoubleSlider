//
//  DoubleSliderConfig.m
//  DoubleSlider
//
//  Created by huangjian on 2019/6/26.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "DoubleSliderConfig.h"

@implementation DoubleSliderConfig

-(instancetype)init
{
    if (self=[super init]) {
        self.leftLineColor = [UIColor orangeColor];
        self.middleLineColor = [UIColor blueColor];
        self.rightLineColor = [UIColor purpleColor];
        self.sliderSize = CGSizeMake(20, 20);
        self.leftSliderColor = [UIColor colorWithRed:100/255.0 green:187/255.0 blue:247/255.0 alpha:0.33];
        self.rightSliderColor = [UIColor colorWithRed:77/255.0 green:217/255.0 blue:100/255.0 alpha:0.33];
        self.lineHeight = 4;
        self.sliderOffsetY = 0;
        self.minValue = 0;
        self.maxValue = 100;
        self.defaultLeftValue = self.minValue;
        self.defaultRightValue = self.maxValue;

    }
    return self;
}

@end
