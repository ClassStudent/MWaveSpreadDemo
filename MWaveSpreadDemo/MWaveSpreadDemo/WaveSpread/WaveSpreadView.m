//
//  waveSpreadView.m
//  MWaveSpreadDemo
//
//  Created by 周远明 on 2017/8/2.
//  Copyright © 2017年 周远明. All rights reserved.
//


#define kKeyPath @"transform.scale"

#import "WaveSpreadView.h"

@implementation WaveSpreadView


#pragma mark - system init -- 系统init方法 ---

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self addWaveViewWithFrame:frame];
    }
    return self;
}

#pragma mark - custom method -- 自定义方法 ---

- (void)addWaveViewWithFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    NSInteger count = 5;
    double duration = 5;
    
    CALayer * animationLayer = [CALayer layer];
    animationLayer.frame = CGRectMake(width * 0.3, height * 0.3, width * 0.4, height * 0.4);
    
    for (int i = 0; i < count; ++ i) {
        CALayer * layer = [CALayer layer];
        layer.backgroundColor = [self getColor].CGColor;
        layer.frame = CGRectMake(0, 0, width * 0.4, height * 0.4);
        layer.borderColor = [UIColor orangeColor].CGColor;
        layer.borderWidth = 1.0f;
        layer.cornerRadius = height * 0.2f;
        layer.opacity = 0.0f;
        
        // 动画之一 scale 大小变化
        CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:kKeyPath];
        basicAnimation.fromValue = @0.5;
        basicAnimation.toValue = @8.0;
        // 动画之一 opacity 透明度变化
        CAKeyframeAnimation * keyanimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        keyanimation.values   = @[@1, @1.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0.0];
        keyanimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * grounpAnimation = [CAAnimationGroup animation];
        grounpAnimation.fillMode = kCAFillModeForwards;
        // 设置时间间隔，动画开始时间不能相同，要不然全部重叠
        grounpAnimation.beginTime = CACurrentMediaTime() + (double)i * duration / (double)count;
        grounpAnimation.duration = duration;// 设置动画持续时间
        grounpAnimation.repeatCount = HUGE_VAL;
        grounpAnimation.timingFunction = defaultCurve;
        grounpAnimation.removedOnCompletion = NO;
        grounpAnimation.animations = @[basicAnimation, keyanimation];
        
        [layer addAnimation:grounpAnimation forKey:@"layer"];
        [animationLayer addSublayer:layer]; //layer叠加
    }
    [self.layer addSublayer:animationLayer];
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = width / 2.0f;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (UIColor *)getColor
{
    return [UIColor orangeColor];
}


#pragma mark - dealloc -- 释放 ---

- (void)dealloc
{
    NSLog(@"%@ === 释放 ===", self.class);
}



@end
