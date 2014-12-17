//
//  StoryView.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-10-22.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "StoryView.h"

@implementation StoryView

@synthesize StoryFinish;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        //背景图片落幕
        [self performSelector:@selector(showBackgroundImageView) withObject:nil afterDelay:1];
    }
    
    return self;
}

//背景图片落幕
- (void)showBackgroundImageView
{
    //背景
    UIImageView *storyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, self.frame.size.width,self.frame.size.height)];
    storyImage.backgroundColor = RGBColor(46,193,254);
    [self addSubview:storyImage];
    
    //草地场景
    UIImageView *groundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width,40)];
    groundImage.backgroundColor = RGBColor(150, 206, 35);
    [storyImage addSubview:groundImage];
    
    [UIView animateWithDuration:2 animations:^{
        
        CGRect storyRect = storyImage.frame;
        storyRect.origin.y = 0;
        storyImage.frame = storyRect;
        
    } completion:^(BOOL finished) {
        
        [self showTreeAndRailImageView];
        
        [self showSunView];
    }];
    
    [[MusicManager shareManager] playMusic:@"storyMusic.mp3"];
}

//大树和栏杆飞出
- (void)showTreeAndRailImageView
{
    UIImageView *treeImage = [[UIImageView alloc] initWithFrame:CGRectMake(-150, self.frame.size.height-270, 150,230)];
    treeImage.image = [UIImage imageNamed:@"tree5.png"];
    [self addSubview:treeImage];
    
    //栏杆场景
    UIImageView *railImage = [[UIImageView alloc] initWithFrame:CGRectMake(-self.frame.size.width, self.frame.size.height-140, self.frame.size.width,100)];
    railImage.image = [UIImage imageNamed:@"rail.png"];
    [self addSubview:railImage];
    
    UILabel *railLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 120, 30)];
    railLab.textAlignment = NSTextAlignmentCenter;
    railLab.textColor = [UIColor brownColor];
    railLab.font = [UIFont boldSystemFontOfSize:14];
    railLab.text = @"故事剧情";
    railLab.backgroundColor = [UIColor clearColor];
    [railImage addSubview:railLab];
    
    [UIView animateWithDuration:1.5 animations:^{
        
        CGRect treeRect = treeImage.frame;
        treeRect.origin.x = 0;
        treeImage.frame = treeRect;
        
        CGRect railRect = railImage.frame;
        railRect.origin.x = 0;
        railImage.frame = railRect;
    } completion:^(BOOL finished) {
        
        [self showTwoRabbiterImageView];
        
    }];
}

//显示太阳
- (void)showSunView
{
    sunImage = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 100,100)];
    sunImage.image = [UIImage imageNamed:@"sun.png"];
    [self addSubview:sunImage];
    
    [self exChangeOut:sunImage dur:1];
}

//两只兔子相遇
- (void)showTwoRabbiterImageView
{
    //兔子场景
    rabbiter1 = [[RabbiterView alloc] initWithFrame:CGRectMake(-40, self.frame.size.height-60-40, 40,70)];
    [self addSubview:rabbiter1];
    
    //兔子场景
    rabbiter2 = [[RabbiterView alloc] initWithFrame:CGRectMake(self.frame.size.width, self.frame.size.height-60-40, 40,70)];
    [rabbiter2 changeRabbiterHeaderImage:[UIImage imageNamed:@"tuzi2.png"]];
    [self addSubview:rabbiter2];
    
    [UIView animateWithDuration:2 animations:^{
        
        CGRect rect1 = rabbiter1.frame;
        rect1.origin.x = 40;
        rabbiter1.frame = rect1;
        
        CGRect rect2 = rabbiter2.frame;
        rect2.origin.x = 180;
        rabbiter2.frame = rect2;
        
    } completion:^(BOOL finished) {
        
        [self showTwoRabbiterChatImageView];
        
    }];
    
}

//两只兔子聊天
- (void)showTwoRabbiterChatImageView
{
    //聊天paopao
    paopaoL = [[UIImageView alloc] initWithFrame:CGRectMake(40, 430, 100,55)];
    paopaoL.image = [UIImage imageNamed:@"paopao_L.png"];
    [self addSubview:paopaoL];
    paopaoL.alpha = 0;
    
    UILabel *label_L = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label_L.textAlignment = UITextAlignmentCenter;
    label_L.font = [UIFont systemFontOfSize:12];
    label_L.text = NSLocalizedString(@"key", nil);
    label_L.textColor = [UIColor blueColor];
    label_L.backgroundColor = [UIColor clearColor];
    [paopaoL addSubview:label_L];
    
    [self performSelector:@selector(showPaopaoL) withObject:paopaoL afterDelay:1];
    
    paopaoR = [[UIImageView alloc] initWithFrame:CGRectMake(120, 430, 100,55)];
    paopaoR.image = [UIImage imageNamed:@"paopao_R.png"];
    [self addSubview:paopaoR];
    paopaoR.alpha = 0;
    
    UILabel *label_R = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label_R.textAlignment = UITextAlignmentCenter;
    label_R.font = [UIFont systemFontOfSize:12];
    label_R.text = @"好的";
    label_R.textColor = [UIColor blueColor];
    label_R.backgroundColor = [UIColor clearColor];
    [paopaoR addSubview:label_R];
}


//显示泡泡L
- (void)showPaopaoL
{
    [UIView animateWithDuration:0.5 animations:^{
        
        paopaoL.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(dissmissPaopaoL) withObject:nil afterDelay:1];
        
    }];
}

//泡泡L消失
- (void)dissmissPaopaoL
{
    [UIView animateWithDuration:0.5 animations:^{
        
        paopaoL.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [paopaoL removeFromSuperview];
        
        [self performSelector:@selector(showPaopaoR) withObject:nil afterDelay:1];;
    }];
}

//显示泡泡R
- (void)showPaopaoR
{
    [UIView animateWithDuration:0.5 animations:^{
        
        paopaoR.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(dissmissPaopaoR) withObject:nil afterDelay:1];
        
    }];
}

//泡泡R消失
- (void)dissmissPaopaoR
{
    [UIView animateWithDuration:0.5 animations:^{
        
        paopaoR.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [paopaoR removeFromSuperview];
        
        [self performSelector:@selector(showTwoRabbiterToghter) withObject:nil afterDelay:0.5];
    }];
}

//两只兔子一起走
- (void)showTwoRabbiterToghter
{
    [UIView animateWithDuration:2 animations:^{
        
        [rabbiter2 changeRabbiterHeaderImage:[UIImage imageNamed:@"tuzi.png"]];
        
        CGRect rect1 = rabbiter1.frame;
        rect1.origin.x = 40+100;
        rabbiter1.frame = rect1;
        
        CGRect rect2 = rabbiter2.frame;
        rect2.origin.x = 200+10;
        rabbiter2.frame = rect2;
    } completion:^(BOOL finished) {
        
        [self showGledeView];
    }];
}

//显示老鹰视图
- (void)showGledeView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = sunImage.frame;
        rect.origin.x = 100;
        rect.origin.y = - rect.size.height;
        sunImage.frame = rect;
        
    } completion:^(BOOL finished) {
        
        cloundImage = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320,150)];
        cloundImage.image = [UIImage imageNamed:@"clound.png"];
        [self addSubview:cloundImage];
        
        gledeImage = [[UIImageView alloc] initWithFrame:CGRectMake(320, 10, 100,100)];
        gledeImage.image = [UIImage imageNamed:@"glede.png"];
        [self addSubview:gledeImage];
        
//        //自定义一个图层
//        gledeLayer = [[CALayer alloc]init];
//        gledeLayer.bounds = CGRectMake(320, 10, 100,100);
//        gledeLayer.position = CGPointMake(320, 10);
//        gledeLayer.contents = (id)[UIImage imageNamed:@"glede.png"].CGImage;
//        [self.layer addSublayer:gledeLayer];
        
        [UIView animateWithDuration:1.5 animations:^{
           
            CGRect cloundRect = cloundImage.frame;
            cloundRect.origin.x = 0;
            cloundImage.frame = cloundRect;
            
            CGRect gledeRect = gledeImage.frame;
            gledeRect.origin.x = 200;
            gledeImage.frame = gledeRect;
            
            gledeLayer.position = CGPointMake(200, 10);
            
        } completion:^(BOOL finished) {
            
            [sunImage removeFromSuperview];
            
            [self translationAnimation];
            
            [self performSelector:@selector(showGledeCatchRabbiter) withObject:nil afterDelay:1.0];
        }];
    }];
}

//老鹰抓兔子飞走了
- (void)showGledeCatchRabbiter
{
    /*
    [UIView animateWithDuration:2 animations:^{
        
        CGRect gledeRect = gledeImage.frame;
        gledeRect.size.width = 140;
        gledeRect.size.height = 140;
        gledeImage.frame = gledeRect;
        
        CGPoint rabb = rabbiter2.center;
        
        gledeImage.center = CGPointMake(rabb.x, rabb.y - rabbiter2.frame.size.height/2 - gledeImage.frame.size.height/2);
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(gledeCatchRabbiterFly) withObject:nil afterDelay:1.0];
        
    }];
     */
    
    [self flyAnimationToPoint:rabbiter2.center withDuration:2 with:gledeImage delegate:self];
}

- (void)finishFlyAnimation
{
    gledeImage.center = CGPointMake(-60, -60);
    rabbiter2.center = CGPointMake(-60, -60);
    
    [self performSelector:@selector(gledeCatchRabbiterFly) withObject:nil afterDelay:1.0];
}

//老鹰带着兔子飞走了
- (void)gledeCatchRabbiterFly
{
    [UIView animateWithDuration:2 animations:^{
        
        rabbiter2.center = CGPointMake(450,-50);
        
        gledeImage.center = CGPointMake(450,-50);
        
    } completion:^(BOOL finished) {
        
        [self dissmissClound];
        
    }];
}

//乌云消失
- (void)dissmissClound
{
    [UIView animateWithDuration:0.5 animations:^{
        
        cloundImage.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [cloundImage removeFromSuperview];
        
        [self performSelector:@selector(showTalk) withObject:nil afterDelay:1];
        
    }];
}

//小兔子要救小伙伴
- (void)showTalk
{
    paopaoL = [[UIImageView alloc] initWithFrame:CGRectMake(140, 430, 150,55)];
    paopaoL.image = [UIImage imageNamed:@"paopao_L.png"];
    [self addSubview:paopaoL];
    paopaoL.alpha = 0;
    
    UILabel *label_L = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    label_L.textAlignment = UITextAlignmentCenter;
    label_L.font = [UIFont systemFontOfSize:12];
    label_L.text = @"我要救我的小伙伴~";
    label_L.textColor = [UIColor blueColor];
    label_L.backgroundColor = [UIColor clearColor];
    [paopaoL addSubview:label_L];
    
    [UIView animateWithDuration:1 animations:^{
        
        paopaoL.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(dismissPop) withObject:nil afterDelay:1.0];
        
        
    }];
}

- (void)dismissPop
{
    [UIView animateWithDuration:1 animations:^{
        
        paopaoL.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [paopaoL removeFromSuperview];
        [self performSelector:@selector(goToSavePartner) withObject:nil afterDelay:1];
        
    }];
}

- (void)goToSavePartner
{
    [UIView animateWithDuration:1.5 animations:^{
        
        CGRect rect = rabbiter1.frame;
        rect.origin.x = 320;
        rabbiter1.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(turnOffThisPage) withObject:nil afterDelay:0.5];
        
    }];
}


//翻页
- (void)turnOffThisPage
{
//    [player stop];
    StoryFinish();
}

#pragma mark 弹出动画
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

#pragma mark 关键帧动画
-(void)translationAnimation
{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧,这里有四个关键帧
    NSValue *key1=[NSValue valueWithCGPoint:gledeLayer.position];//对于关键帧动画初始值不能省略
    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(200, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(80, 500)];
    NSArray *values=[NSArray arrayWithObjects:key1,key2,key3,key4, nil];
    keyframeAnimation.values=values;
    //设置其他属性
    keyframeAnimation.duration=3.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+2;//设置延迟2秒执行
    
    //3.添加动画到图层，添加动画后就会执行动画
    [gledeLayer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}


#pragma mark 飞行动画
-(void)flyAnimationToPoint:(CGPoint)point withDuration:(float)duration with:(UIView *)view delegate:(id)delegate
{
	CGPoint pointerSize = view.center;
	CALayer *welcomeLayer = view.layer;
	
    // 位移的动画效果
	CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	bounceAnimation.removedOnCompletion = NO;
	
    //设置移动结束位置
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGFloat midX,midY;
	midX = point.x;
	midY = point.y;
	
    // 设置移动路径
	CGPathMoveToPoint(thePath, NULL, pointerSize.x, pointerSize.y);
	CGPathAddQuadCurveToPoint(thePath,NULL,150,30,midX,midY);
	
	bounceAnimation.path = thePath;
	CGPathRelease(thePath);
	
    // 缩小动画效果
	CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	transformAnimation.removedOnCompletion = YES;
	transformAnimation.duration = duration;
	transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1,1,1)];
	transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5,1.5,1.5)];
	
	
    // 动画数组
	CAAnimationGroup *theGroup = [CAAnimationGroup animation];
	
    // 将动画放入数组中
	theGroup.delegate = delegate;
	theGroup.duration = 1.8;
	theGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	theGroup.animations = [NSArray arrayWithObjects:bounceAnimation, transformAnimation, nil];
	
    //执行动画
	[welcomeLayer addAnimation:theGroup forKey:@"animatePlacardViewFromCenter"];
}


- (void)animationDidStart:(CAAnimation *)anim
{
    CGRect rect = gledeImage.frame;
    rect.size.width = 120;
    rect.size.height = 120;
    gledeImage.frame = rect;
    
    gledeImage.center = CGPointMake(rabbiter2.center.x, rabbiter2.center.y-10);
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    CGRect rect = gledeImage.frame;
//    rect.size.width = 120;
//    rect.size.height = 120;
//    gledeImage.frame = rect;
    
//    gledeImage.center = CGPointMake(rabbiter2.center.x, rabbiter2.center.y-10);
    
    [self flyAnimationToPoint:CGPointMake(-60, -60) withDuration:2 with:gledeImage delegate:nil];
    [self flyAnimationToPoint:CGPointMake(-60, -60) withDuration:2 with:rabbiter2 delegate:nil];
    
    [self performSelector:@selector(finishFlyAnimation) withObject:nil afterDelay:1.8];
}

- (void)dealloc
{
    
}

@end
