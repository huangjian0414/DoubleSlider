//
//  DoubleSlider.m
//  DoubleSlider
//
//  Created by huangjian on 2019/6/26.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "DoubleSlider.h"
#import "UIView+HJViewFrame.h"

@interface DoubleSlider ()
//slider位置偏移，默认垂直居中
@property(nonatomic,assign)CGFloat sliderOffsetY;

@property(nonatomic,strong)UIView *backgroundLine;
@property(nonatomic,strong)UIView *leftLine;
@property(nonatomic,strong)UIView *rightLine;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,assign)CGFloat minValue;
@property(nonatomic,assign)CGFloat maxValue;

@property(nonatomic,assign)CGFloat currentLeftValue;
@property(nonatomic,assign)CGFloat currentRightValue;
@end
@implementation DoubleSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sliderOffsetY = 0;
        self.minValue = 0;
        self.maxValue = 100;
        [self setUpUI];
    }
    return self;
}

-(void)setConfig:(DoubleSliderConfig *)config
{
    _config = config;
    self.backgroundLine.backgroundColor = config.middleLineColor;
    self.leftLine.backgroundColor = config.leftLineColor;
    self.rightLine.backgroundColor = config.rightLineColor;
    self.leftButton.size = self.rightButton.size = config.sliderSize;
    self.leftButton.backgroundColor = config.leftSliderColor;
    self.rightButton.backgroundColor = config.rightSliderColor;
    CGFloat lineH = config.lineHeight;
    if (config.lineHeight > self.height) {
        lineH = self.height;
    }
    self.backgroundLine.height=self.leftLine.height=self.rightLine.height=lineH;
    self.sliderOffsetY = config.sliderOffsetY;
    self.minValue = config.minValue;
    if (config.minValue <= config.maxValue&&config.minValue>=0&&config.maxValue>=0) {
        self.minValue = config.minValue;
        self.maxValue = config.maxValue;
    }
    if (config.defaultLeftValue<=config.defaultRightValue&&config.defaultLeftValue>=0&&config.defaultRightValue>=0) {
        self.leftButton.centerX = (config.defaultLeftValue-config.minValue)/(config.maxValue-config.minValue)*self.backgroundLine.width;
        self.leftLine.width = self.leftButton.centerX;
        self.rightButton.centerX = (config.defaultRightValue-config.minValue)/(config.maxValue-config.minValue)*self.backgroundLine.width;
        self.rightLine.x = self.rightButton.centerX;
        self.rightLine.width = self.width-self.rightButton.centerX;
        self.currentLeftValue = config.defaultLeftValue;
        self.currentRightValue = config.defaultRightValue;
    }
}


//MARK: - 拖左边的按钮
-(void)panleftSliderBtn:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    static CGPoint rightCenter;
    static  CGPoint leftCenter;
    if (pan.state == UIGestureRecognizerStateBegan) {//记录原始位置
        rightCenter = self.rightButton.center;
        leftCenter = self.leftButton.center;
    }
    self.leftButton.centerX = leftCenter.x + point.x;
    NSLog(@"----%lf--%lf",point.x,rightCenter.x);
    if (pan.state == UIGestureRecognizerStateChanged) {
        [self tapLeftRefresh:point rightCenter:rightCenter leftCenter:leftCenter];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {

        [self tapLeftRefresh:point rightCenter:rightCenter leftCenter:leftCenter];
        
    }
}
-(void)tapLeftRefresh:(CGPoint)point rightCenter:(CGPoint)rightCenter leftCenter:(CGPoint)leftCenter{
    if (self.leftButton.centerX > rightCenter.x) {//拖左边按钮超过右边按钮的位置
        self.leftButton.centerX = rightCenter.x;
        self.rightLine.x = rightCenter.x + point.x - (self.leftButton.centerX - leftCenter.x);
        self.rightLine.width = self.width-self.rightLine.x;
        self.rightButton.centerX = leftCenter.x + point.x;
        if (self.rightButton.centerX>self.width) {
            self.rightLine.width = 0;
            self.rightButton.centerX = self.width ;
        }
        [self rightValueChange:self.rightButton.centerX];
    }else{
        if (self.leftButton.centerX < 0) {
            self.leftButton.centerX = 0;
        }
        if (self.leftButton.centerX > self.width) {
            self.leftButton.centerX = self.width;
        }
        //将右边的重置回原样
        self.rightButton.centerX = rightCenter.x;
        self.rightLine.x = rightCenter.x;
        self.rightLine.width = self.width - self.rightLine.x;

        [self leftValueChange:self.leftButton.centerX];
    }
    self.leftLine.width = self.leftButton.centerX;
    
}
//MARK: - 拖右边的按钮
-(void)panrightSliderBtn:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    static CGPoint rightCenter;
    static  CGPoint leftCenter;
    if (pan.state == UIGestureRecognizerStateBegan) {
        rightCenter = self.rightButton.center;
        leftCenter = self.leftButton.center;
    }
    NSLog(@"---Max %lf",point.x);
    self.rightButton.centerX = rightCenter.x + point.x;
    if (pan.state == UIGestureRecognizerStateChanged) {
        [self tapRightRefresh:point rightCenter:rightCenter leftCenter:leftCenter];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self tapRightRefresh:point rightCenter:rightCenter leftCenter:leftCenter];
    }
}
-(void)tapRightRefresh:(CGPoint)point rightCenter:(CGPoint)rightCenter leftCenter:(CGPoint)leftCenter{
    if (self.rightButton.x < leftCenter.x-self.leftButton.frame.size.width/2) {//拖右边按钮超过左边按钮的位置
        self.rightButton.x = leftCenter.x-self.leftButton.frame.size.width/2;
        self.leftLine.width = leftCenter.x + point.x + (rightCenter.x-self.rightButton.centerX);
        self.leftButton.centerX = rightCenter.x + point.x;
        
        if (self.leftButton.centerX<0) {
            self.leftLine.x = 0;
            self.leftLine.width = 0;
            self.leftButton.centerX = 0;
        }
        [self leftValueChange:self.leftButton.centerX];
        
    }else{
        if (self.rightButton.centerX < 0) {
            self.rightButton.centerX = 0;
        }
        if (self.rightButton.centerX > self.width) {
            self.rightButton.centerX = self.width;
        }
        //将左边的重置回原来的位置
        self.leftButton.centerX = leftCenter.x;
        self.leftLine.width = leftCenter.x;
        [self rightValueChange:self.rightButton.centerX];
    }
    self.rightLine.x = self.rightButton.centerX;
    self.rightLine.width = self.width-self.rightButton.centerX;
}
//MARK: - 滑块值的改变以及响应
-(void)leftValueChange:(CGFloat)maxX{
    CGFloat radio = maxX/self.backgroundLine.width;
    if (self.currentLeftValue != (self.maxValue-self.minValue)*radio) {
        self.currentLeftValue = (self.maxValue-self.minValue)*radio;
        if (self.panResponse) {
            self.panResponse(self.currentLeftValue, self.currentRightValue, self.leftButton.center, self.rightButton.center);
        }
    }
}
-(void)rightValueChange:(CGFloat)maxX{
    CGFloat radio = maxX/self.backgroundLine.width;
    if (self.currentRightValue != (self.maxValue-self.minValue)*radio) {
        self.currentRightValue = (self.maxValue-self.minValue)*radio;
        if (self.panResponse) {
            self.panResponse(self.currentLeftValue, self.currentRightValue, self.leftButton.center, self.rightButton.center);
        }
    }
}

//MARK: - UI
-(void)setUpUI
{
    UIView *backgroundLine = [[UIView alloc]init];
    backgroundLine.backgroundColor = [UIColor blueColor];
    [self addSubview:backgroundLine];
    self.backgroundLine=backgroundLine;
    
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = [UIColor orangeColor];
    [self addSubview:leftLine];
    self.leftLine = leftLine;
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = [UIColor purpleColor];
    [self addSubview:rightLine];
    self.rightLine = rightLine;
    
    backgroundLine.frame = CGRectMake(0, self.sliderOffsetY+self.height/2-2, self.frame.size.width, 4);
    leftLine.frame = CGRectMake(0, self.sliderOffsetY+self.height/2-2, 0, 4);
    rightLine.frame = CGRectMake(self.frame.size.width, self.sliderOffsetY+self.height/2-2, 0, 4);
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(-10, self.sliderOffsetY+self.height/2-10, 20, 20);
    leftButton.backgroundColor = [UIColor colorWithRed:100/255.0 green:187/255.0 blue:247/255.0 alpha:0.33];
    leftButton.layer.cornerRadius = leftButton.width/2.0f;
    leftButton.layer.masksToBounds = YES;
    leftButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    leftButton.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *leftSliderBtnPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panleftSliderBtn:)];
    [leftButton addGestureRecognizer:leftSliderBtnPan];
    [self addSubview:leftButton];
    self.leftButton = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(self.width-10, self.sliderOffsetY+self.height/2-10, 20, 20);
    rightButton.backgroundColor = [UIColor colorWithRed:77/255.0 green:217/255.0 blue:100/255.0 alpha:0.33];
    rightButton.layer.cornerRadius = rightButton.width/2.0f;
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    rightButton.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *rightSliderBtnPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panrightSliderBtn:)];
    [rightButton addGestureRecognizer:rightSliderBtnPan];
    [self addSubview:rightButton];
    self.rightButton = rightButton;
    
}
//MARK: - 按钮超出视图响应
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint leftPoint = [self.leftButton convertPoint:point fromView:self];
    CGPoint rightPoint = [self.rightButton convertPoint:point fromView:self];
    if ([self.leftButton pointInside:leftPoint withEvent:event]){
        return self.leftButton;
    }
    if ([self.rightButton pointInside:rightPoint withEvent:event]){
        return self.rightButton;
    }
    return [super hitTest:point withEvent:event];
}
@end
