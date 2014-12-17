//
//  AnmationEngin.m
//  Fighting
//
//  Created by kangqijun on 14/11/5.
//  Copyright (c) 2014年 kangqijun. All rights reserved.
//

#import "AnimationEngin.h"

@implementation AnimationEngin
@synthesize contentView;

+ (void)flyAnimationQuadCurveToPoint:(CGPoint)toPoint withTime:(float)duration withTime:(UIView *)view
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	//Set some variables on the animation
	pathAnimation.calculationMode = kCAAnimationPaced;
	//We want the animation to persist - not so important in this case - but kept for clarity
	//If we animated something from left to right - and we wanted it to stay in the new position,
	//then we would need these parameters
	pathAnimation.fillMode = kCAFillModeForwards;
	pathAnimation.removedOnCompletion = NO;
	pathAnimation.duration = duration;
	//Lets loop continuously for the demonstration
//	pathAnimation.repeatCount = 1;
	
    //抛物线轨迹
    CGFloat cpx = [UIScreen mainScreen].bounds.size.height/2;
    CGFloat cpy = 0;
    
    if (view.frame.origin.y > [UIScreen mainScreen].bounds.size.width/2)
    {
        cpy = [UIScreen mainScreen].bounds.size.width - 10;
    }
    else
    {
        cpy = 10;
    }
    
    CGFloat cpx1 = [UIScreen mainScreen].bounds.size.height/2;
    CGFloat cpy1 = 0;
    
    if (view.frame.origin.y > [UIScreen mainScreen].bounds.size.width/2)
    {
        cpy1 = 10;
    }
    else
    {
        cpy1 = [UIScreen mainScreen].bounds.size.width - 10;
    }
    
	CGMutablePathRef curvedPath = CGPathCreateMutable();
	CGPathMoveToPoint(curvedPath, NULL, view.frame.origin.x, view.frame.origin.y);
	CGPathAddQuadCurveToPoint(curvedPath, NULL, cpx, cpy, toPoint.x/2 + 70 , toPoint.y);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, cpx1, cpy1, toPoint.x, toPoint.y);
    [pathAnimation setPath:curvedPath];
    CFRelease(curvedPath);
    
    [view.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}


+ (void)flyAddSmallerAnimationToPoint:(CGPoint)toPoint withTime:(float)duration withTime:(UIView *)view
{
    AnimationEngin *engin = [[AnimationEngin alloc] init];
    engin.contentView = view;
    
	CGPoint pointerSize = view.center;
	CALayer *welcomeLayer = view.layer;
	
    // 位移的动画效果
	CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	bounceAnimation.removedOnCompletion = NO;
	
    //设置移动结束位置
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGFloat midX,midY;
	midX = toPoint.x;
	midY = toPoint.y;
	
    // 设置移动路径
	CGPathMoveToPoint(thePath, NULL, pointerSize.x, pointerSize.y);
	CGPathAddQuadCurveToPoint(thePath,NULL,pointerSize.x,pointerSize.y,midX,midY);
	
	bounceAnimation.path = thePath;
	CGPathRelease(thePath);
	
    // 缩小动画效果
	CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	transformAnimation.removedOnCompletion = YES;
	transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1,1,1)];
	transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5,0.5,0.5)];
    
    // 动画数组
	CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    // 将动画放入数组中
	theGroup.delegate = engin;
	theGroup.duration = duration;
	theGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	theGroup.animations = [NSArray arrayWithObjects:bounceAnimation, transformAnimation, nil];
	
    //执行动画
	[welcomeLayer addAnimation:theGroup forKey:@"animatePlacardViewFromCenter"];

}

- (void)animationDidStart:(CAAnimation *)anim
{
    CGRect rect = self.contentView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    self.contentView.frame = rect;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self.contentView removeFromSuperview];
    }
}

//跑马灯动画
+ (void)showMarqueeAnimation:(UIView *)view
{
    [UIView animateWithDuration:10.0
                          delay:0
                        options:UIViewAnimationOptionRepeat //动画重复的主开关
     |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                     animations:^{
                         
                         CGRect frame = view.frame;
                         frame.origin.x = frame.size.width;
                         view.frame = frame;
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }
     ];
}

//抖动动画
+ (void)shakeAnimation:(UIView *)view repeatCount:(NSInteger)num
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:- 0.2];
    shake.toValue   = [NSNumber numberWithFloat:+ 0.2];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = num;
    
    [view.layer addAnimation:shake forKey:@"bagShakeAnimation"];
}

//上下浮动动画
+ (void)driftAnimation:(UIView *)view withTime:(float)duration Yoffset:(float)offset;
{
    float Yorigin = view.frame.origin.y;
    
    [UIView animateWithDuration:10.0
                          delay:0
                        options:UIViewAnimationOptionRepeat //动画重复的主开关
     |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                     animations:^{
                         
                         CGRect frame = view.frame;
                         frame.origin.y = offset;
                         view.frame = frame;
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [self driftAnimation:view withTime:duration Yoffset:Yorigin];
                         
                     }
     ];
}

@end
