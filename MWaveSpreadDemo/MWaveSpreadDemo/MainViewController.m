//
//  MainViewController.m
//  MWaveSpreadDemo
//
//  Created by 周远明 on 2019/2/12.
//  Copyright © 2019年 周远明. All rights reserved.
//

#import "MainViewController.h"
#import "WaveSpreadView.h"

@interface MainViewController ()

@property (nonatomic, strong) WaveSpreadView * waveView;

@end

@implementation MainViewController


#pragma mark - system method -- 系统方法 ---

- (void)viewDidLoad {
    [super viewDidLoad];
    [self waveViews]; // 组合效果
//    [self single]; // 单个效果
}

#pragma mark - custom method -- 自定义方法 ---

- (void)waveViews
{
    CGFloat wvX = self.view.bounds.size.width / 2.0;
    CGFloat wvY = self.view.bounds.size.height / 2.0;
    CGRect wvFrame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    self.waveView = [[WaveSpreadView alloc] initWithFrame:wvFrame];
    self.waveView.center = CGPointMake(wvX, wvY);
    [self.view addSubview:self.waveView];
}
- (void)single
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = CGRectMake(width * 0.3, height * 0.3, width * 0.4, width * 0.4);
    layer.borderColor = [UIColor orangeColor].CGColor;
    layer.borderWidth = 1.0f;
    layer.cornerRadius = width * 0.4 * 0.5f;
    layer.opacity = 0.0f;
    
    // 动画之一 scale 大小变化
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = @0.5;
    basicAnimation.toValue = @3.0;
    
    // 动画之一 opacity 透明度变化
    CAKeyframeAnimation * keyanimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyanimation.values   = @[@1, @1.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0.0];
    keyanimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    
    CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CAAnimationGroup * grounpAnimation = [CAAnimationGroup animation];
    grounpAnimation.fillMode = kCAFillModeForwards;
    grounpAnimation.beginTime = CACurrentMediaTime();// 设置动画开始时间
    grounpAnimation.duration = 3;// 设置动画持续时间
    grounpAnimation.repeatCount = HUGE_VAL;
    grounpAnimation.timingFunction = defaultCurve;
    grounpAnimation.removedOnCompletion = NO;
    grounpAnimation.animations = @[basicAnimation, keyanimation];// 添加动画s
    [layer addAnimation:grounpAnimation forKey:@"layer"];
    [self.view.layer addSublayer:layer];
}


@end
