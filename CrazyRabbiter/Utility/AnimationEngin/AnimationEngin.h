//
//  AnmationEngin.h
//  Fighting
//
//  Created by kangqijun on 14/11/5.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface AnimationEngin : NSObject
{
    UIView *contentView;
}

@property (strong, nonatomic) UIView *contentView;

+ (void)flyAnimationQuadCurveToPoint:(CGPoint)toPoint withTime:(float)duration withTime:(UIView *)view;

+ (void)flyAddSmallerAnimationToPoint:(CGPoint)toPoint withTime:(float)duration withTime:(UIView *)view;

//跑马灯动画
+ (void)showMarqueeAnimation:(UIView *)view;

//抖动动画
+ (void)shakeAnimation:(UIView *)view repeatCount:(NSInteger)num;

//上下浮动动画
+ (void)driftAnimation:(UIView *)view withTime:(float)duration Yoffset:(float)offset;

@end
