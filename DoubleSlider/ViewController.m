//
//  ViewController.m
//  DoubleSlider
//
//  Created by huangjian on 2019/6/26.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "ViewController.h"
#import "DoubleSlider.h"
#import "UIView+HJViewFrame.h"
@interface ViewController ()
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DoubleSlider *slider = [[DoubleSlider alloc]initWithFrame:CGRectMake(30, 100, 200, 20)];
    DoubleSliderConfig *config = [[DoubleSliderConfig alloc]init];
    config.defaultLeftValue = 40;
    config.defaultRightValue = 80;
    slider.config = config;
    [self.view addSubview:slider];
    __weak __typeof(&*self)weakSelf = self;
    slider.panResponse = ^(CGFloat leftValue, CGFloat rightValue, CGPoint leftCenter, CGPoint rightCenter) {
      NSLog(@"currentValue -- %lf---%lf --%lf--%lf",leftValue,rightValue,leftCenter.x,rightCenter.x);
        weakSelf.leftLabel.centerX = 30 + leftCenter.x;
        weakSelf.leftLabel.text = [NSString stringWithFormat:@"%.2f",leftValue];
        weakSelf.rightLabel.centerX = 30 + rightCenter.x;
        weakSelf.rightLabel.text = [NSString stringWithFormat:@"%.2f",rightValue];
    };
    
    self.leftLabel = [[UILabel alloc]init];
    self.leftLabel.font = [UIFont systemFontOfSize:10];
    self.leftLabel.text = @"40.00";
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.leftLabel];
    self.leftLabel.size = CGSizeMake(40, 20);
    self.leftLabel.centerY = slider.y-self.leftLabel.height/2;
    
    self.leftLabel.centerX = 30 + (config.defaultLeftValue-config.minValue)/(config.maxValue-config.minValue)*slider.width;
    
    self.rightLabel = [[UILabel alloc]init];
    self.rightLabel.font = [UIFont systemFontOfSize:10];
    self.rightLabel.text = @"80.00";
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.rightLabel];
    self.rightLabel.size = CGSizeMake(40, 20);
    self.rightLabel.centerY = slider.y-self.rightLabel.height/2;
    self.rightLabel.centerX = 30 + (config.defaultRightValue-config.minValue)/(config.maxValue-config.minValue)*slider.width;
}


@end
