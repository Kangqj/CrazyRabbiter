//
//  SceneView.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "SceneView.h"
#import "Utils.h"
#import <AudioToolbox/AudioToolbox.h>

//3.0初速度需要60秒减少至0
const float MaxTime = 50;
//加速度，方向向下
const float VG = 0.05;
//初速度
const float MaxV = 2.5;

@implementation SceneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGBColor(46,193,254);
        
        //天空
//        UIImageView *skyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
//        skyImage.image = [UIImage imageNamed:@"sky.png"];
//        [self addSubview:skyImage];
        
        //树
        UIImageView *treeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-260, 150,230)];
        treeImage.image = [UIImage imageNamed:@"tree.png"];
        [self addSubview:treeImage];
        
        //栏杆场景
        railImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-140, frame.size.width,100)];
        railImage1.image = [UIImage imageNamed:@"rail.png"];
        [self addSubview:railImage1];
        
        railLab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 120, 30)];
        railLab1.textAlignment = NSTextAlignmentCenter;
        railLab1.textColor = [UIColor brownColor];
        railLab1.font = [UIFont boldSystemFontOfSize:14];
        railLab1.text = @"预备";
        railLab1.backgroundColor = [UIColor clearColor];
        [railImage1 addSubview:railLab1];
        
        railImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width, frame.size.height-140, frame.size.width,100)];
        railImage2.image = [UIImage imageNamed:@"rail.png"];
        [self addSubview:railImage2];
        
        railLab2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 120, 30)];
        railLab2.textAlignment = NSTextAlignmentCenter;
        railLab2.textColor = [UIColor brownColor];
        railLab2.font = [UIFont boldSystemFontOfSize:14];
        railLab2.text = @"10米";
        railLab2.backgroundColor = [UIColor clearColor];
        [railImage2 addSubview:railLab2];
        
        //苹果飞行场景
        fruitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        fruitView.userInteractionEnabled = NO;
        fruitView.backgroundColor = [UIColor clearColor];
        [self addSubview:fruitView];
        
        //草地场景
        UIImageView *groundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width,40)];
        groundImage.backgroundColor = RGBColor(150, 206, 35);
        [self addSubview:groundImage];
                
        //兔子场景
        rabbiter = [[RabbiterView alloc] initWithFrame:CGRectMake(100, frame.size.height-60-40, 40,70)];
        [self addSubview:rabbiter];
        
        //得分lab
        gradeLab = [[UILabel alloc] initWithFrame:CGRectMake(215, 20, 100, 30)];
        gradeLab.textAlignment = NSTextAlignmentRight;
        gradeLab.textColor = [UIColor blueColor];
        gradeLab.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:gradeLab];
        
        UIButton *temporaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        temporaryBtn.frame = CGRectMake(0, 0, 100, 40);
        [temporaryBtn addTarget:self action:@selector(temporaryGame) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:temporaryBtn];
        
        //跳跃手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpTap)];
        [self addGestureRecognizer:tapGesture];
        
        //主计时器
        threadTimer = [NSTimer scheduledTimerWithTimeInterval:0.010
                                                       target:self
                                                     selector:@selector(sceneMainRunLoop)
                                                     userInfo:nil
                                                      repeats:YES];
        
        start = NO;
        
        fruitArr = [[NSMutableArray alloc] init];
        cloundArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

//暂停游戏
- (void)temporaryGame
{
    start = NO;
}

//点击背景跳跃方法
- (void)jumpTap
{
    if (!start)
    {
        start = YES;
        
        [KProgressHUD showHUDWithText:@"小兔子开始旅行了！"];
    }
    
    start = YES;
    
    maxJumpTime = MaxTime;
    
    //播放跳跃的声音
    [self playJumpSound];
}

- (void)sceneMainRunLoop
{
    if (start)
    {
        //兔子跳跃
        [self rabbiterJumpAnimation];
        
        //随机生成云
        [self createCloundView];
        
        //随机生成水果
        [self createFruitView];
        
        //检测兔子是否碰到食物
        [self checkHit];
        
        //背景滚动
        [self backgroundTurnAround];
    }
}

//背景滚动
- (void)backgroundTurnAround
{
    CGRect rect1 = railImage1.frame;
    rect1.origin.x -= 0.5;
    railImage1.frame = rect1;
    
    if (rect1.origin.x == -320)
    {
        rect1.origin.x = 320;
        railImage1.frame = rect1;
        
        railLab1.text = [NSString stringWithFormat:@"%d米",[railLab2.text intValue]+10];
    }
    
    CGRect rect2 = railImage2.frame;
    rect2.origin.x -= 0.5;
    railImage2.frame = rect2;
    
    if (rect2.origin.x == -320)
    {
        rect2.origin.x = 320;
        railImage2.frame = rect2;
        
        railLab2.text = [NSString stringWithFormat:@"%d米",[railLab1.text intValue]+10];
    }
    
    if (eatCount%10 == 0 &&  eatCount/10 > 0)
    {
        CGRect rect = rabbiter.frame;
        
        if (rect.size.width < 40 + eatCount/10 * 5)
        {
            [KProgressHUD showHUDWithText:@"小兔子长大了!"];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = rabbiter.frame;
                rect.size.width = 40 + eatCount/10 * 5;
                rect.size.height = 70 + eatCount/10 * 5;
                rabbiter.frame = rect;
                
                [rabbiter growUp];
            }];
        }
    }
}

//兔子跳跃算法
- (void)rabbiterJumpAnimation
{
    maxJumpTime --;
    
    CGRect rect = rabbiter.frame;
    
    rect.origin.y = rect.origin.y - (MaxV - (MaxTime - maxJumpTime)*VG);
    
    if (rect.origin.y > self.frame.size.height-rect.size.height-40)
    {
        rect.origin.y = self.frame.size.height-rect.size.height-40;
    }
    
    if (rect.origin.y < 20)
    {
        rect.origin.y = 20;
    }
    
    rabbiter.frame = rect;
}

//生成食物
- (void)createFruitView
{
    CGRect rect = fruitView.frame;
    rect.origin.x -= 0.5;
    fruitView.frame = rect;
    
    if (timerCount == 30)
    {
        int hight = [UIScreen mainScreen].bounds.size.height - 53-30;
        NSInteger tmpY = [Utils getRandomNumberBetween:30 to:hight];
        
        int perY = tmpY/10;
        int yValue = perY*10;
        
        //水果
        UIImageView *foodImage = [[UIImageView alloc] initWithFrame:CGRectMake(320 - rect.origin.x, yValue, 30, 30)];
        NSInteger imageId = [Utils getRandomNumberBetween:1 to:8];
        foodImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",imageId]];
        [fruitView addSubview:foodImage];
        
        [fruitArr addObject:foodImage];
        
        timerCount = 0;
    }
    
    timerCount ++;
}

//生成云
- (void)createCloundView
{
    CGRect rect = fruitView.frame;
    rect.origin.x -= 0.5;
    fruitView.frame = rect;
    
    if (timerCount == 30)
    {
        NSInteger tmpY = [Utils getRandomNumberBetween:30 to:200];
        
        int perY = tmpY/10;
        int yValue = perY*10;
        
        //云
        UIImageView *yunImage = [[UIImageView alloc] initWithFrame:CGRectMake(320 - rect.origin.x, yValue, 100,40)];
        yunImage.image = [UIImage imageNamed:@"yun.png"];
        [fruitView addSubview:yunImage];
        
        [cloundArr addObject:yunImage];
    }
}


//检测兔子是否碰到食物
- (void)checkHit
{
    [fruitArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *foodImage = (UIImageView *)obj;
        
        CGRect foodRect = foodImage.frame;
        
        CGRect rect = CGRectMake(foodRect.origin.x + fruitView.frame.origin.x, foodRect.origin.y, foodRect.size.width, foodRect.size.height);
        if (CGRectContainsPoint(rect,rabbiter.center))
        {
            [fruitArr removeObject:foodImage];
            [foodImage removeFromSuperview];
            
            //分数抖动动画
            [self bagShakeAnimation];
            
            //播放声音
            [self playFruitEatSound];
            
            //[self setAnimationWithLayer:foodImage];
            
            eatCount ++;
            gradeLab.text = [NSString stringWithFormat:@"吃了%d个",eatCount];
        }
        
        //移除飘出屏幕的食物
        if (rect.origin.x + rect.size.width < 0)
        {
            [fruitArr removeObject:foodImage];
            [foodImage removeFromSuperview];
        }
    }];
    
    //移除飘出屏幕的云
    [cloundArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *cloundImage = (UIImageView *)obj;
        
        CGRect cloundRect = cloundImage.frame;
        
        CGRect rect = CGRectMake(cloundRect.origin.x + fruitView.frame.origin.x, cloundRect.origin.y, cloundRect.size.width, cloundRect.size.height);
        
        if (rect.origin.x + rect.size.width < 0)
        {
            [cloundArr removeObject:cloundImage];
            [cloundImage removeFromSuperview];
        }
        
    }];
}


//福袋晃动动画
- (void)bagShakeAnimation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:- 0.2];
    shake.toValue   = [NSNumber numberWithFloat:+ 0.2];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = 4;
    
    [gradeLab.layer addAnimation:shake forKey:@"bagShakeAnimation"];
}


//播放吃到水果的声音
- (void)playFruitEatSound
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        AudioServicesPlaySystemSound(1003);
//    });
}

//播放跳跃的声音
- (void)playJumpSound
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        AudioServicesPlaySystemSound(1004);
//    });
}


@end
