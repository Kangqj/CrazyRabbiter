//
//  SceneView.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "SceneView.h"
#import "Utils.h"
/*
#import <ShareSDK/ShareSDK.h>
#import <AGCommon/AGCommon.h>
*/

#define  GameTime    60

//3.0初速度需要60秒减少至0
const float MaxTime = 50;
//加速度，方向向下
const float VG = 0.05;
//初速度
const float MaxV = 2.5;

@implementation SceneView

@synthesize RestartBlk, BackToChooseBlk, start;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //天空
//        UIImageView *skyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
//        skyImage.image = [UIImage imageNamed:@"sky.png"];
//        [self addSubview:skyImage];
        
        sunImage = [[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 60,60)];
        [self addSubview:sunImage];
        
        //滚动动画视图
        bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height-40)];
        bgView1.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView1];
        
        bgView2 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width,frame.size.height-40)];
        bgView2.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView2];
        
        //树场景
        treeImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(160, bgView2.frame.size.height-230, 150,230)];
        treeImage1.image = [UIImage imageNamed:@"tree1.png"];
        [bgView1 addSubview:treeImage1];
        
        treeImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, bgView2.frame.size.height-230, 150,230)];
        treeImage2.image = [UIImage imageNamed:@"tree2.png"];
        [bgView2 addSubview:treeImage2];
        
        //栏杆场景
        UIImageView *railImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgView2.frame.size.height-100, frame.size.width,100)];
        railImage1.image = [UIImage imageNamed:@"rail.png"];
        [bgView1 addSubview:railImage1];
        
        railLab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 120, 30)];
        railLab1.textAlignment = NSTextAlignmentCenter;
        railLab1.textColor = RGBColor(128, 42, 42);
        railLab1.font = [UIFont boldSystemFontOfSize:16];
        railLab1.text = NSLocalizedString(@"出发!", nil);
        railLab1.backgroundColor = [UIColor clearColor];
        [railImage1 addSubview:railLab1];
        
        UIImageView *railImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgView2.frame.size.height-100, frame.size.width,100)];
        railImage2.image = [UIImage imageNamed:@"rail.png"];
        [bgView2 addSubview:railImage2];
        
        railLab2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 120, 30)];
        railLab2.textAlignment = NSTextAlignmentCenter;
        railLab2.textColor = RGBColor(128, 42, 42);
        railLab2.font = [UIFont boldSystemFontOfSize:14];
        railLab2.text = [NSString stringWithFormat:@"10%@",NSLocalizedString(@"米", nil)];
        railLab2.backgroundColor = [UIColor clearColor];
        [railImage2 addSubview:railLab2];
        
        //苹果飞行场景
        fruitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        fruitView.userInteractionEnabled = NO;
        fruitView.backgroundColor = [UIColor clearColor];
        [self addSubview:fruitView];
        
        NSInteger br = [Utils getRandomNumberBetween:0 to:255];
        NSInteger bg = [Utils getRandomNumberBetween:0 to:255];
        NSInteger bb = [Utils getRandomNumberBetween:0 to:255];
        
        noteView = [[UITextView alloc] initWithFrame:CGRectMake(80, 200, 160, 50)];
        noteView.backgroundColor = RGBColor(br, bg, bb);//[UIColor colorWithRed:189/255.0 green:254/255.0 blue:246/255.0 alpha:1.0];
        noteView.editable = NO;
        noteView.textColor = RGBColor(128, 42, 42);//RGBColor(150, 206, 35);
        noteView.font = [UIFont boldSystemFontOfSize:30];
        noteView.textAlignment = NSTextAlignmentLeft;
        noteView.layer.cornerRadius = 8;
        [fruitView addSubview:noteView];
        noteView.text = [NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"关卡", nil),[GameSetManager shareManager].level];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:@"level.png"];
        [noteView addSubview:imageView];
        
        //草地场景
        UIImageView *groundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width,40)];
        groundImage.backgroundColor = RGBColor(115, 74, 18);//RGBColor(r, g, b);
        [self addSubview:groundImage];
        
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
//        lineView.backgroundColor = RGBColor(252, 230, 201);;
//        [groundImage addSubview:lineView];
        
        /*
        if ([GameSetManager shareManager].level >= 2)
        {
            groundImage.backgroundColor = RGBColor(154, 33, 32);
            
            for (int i = 0; i < 2; i++)
            {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 10 + 20*i, self.frame.size.width, 10)];
                lineView.backgroundColor = [UIColor whiteColor];
                [groundImage addSubview:lineView];
            }
            
//            for (int i = 0; i < 2; i++)
//            {
//                UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 20*i, 50, 10)];
//                numLab.backgroundColor = [UIColor clearColor];
//                numLab.textAlignment = NSTextAlignmentRight;
//                numLab.text = [NSString stringWithFormat:@"%d",i];
//                numLab.textColor = [UIColor whiteColor];
//                numLab.font = [UIFont systemFontOfSize:10];
//                numLab.layer.borderColor = [UIColor whiteColor].CGColor;
//                numLab.layer.borderWidth = 1.0;
//                [groundImage addSubview:numLab];
//            }
        }
        */
        
        timeProgressView = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        timeProgressView.showText = @NO;
        timeProgressView.progress = 1.0;
        timeProgressView.borderRadius = @5;
        timeProgressView.type = LDProgressSolid;
        [self addSubview:timeProgressView];
        timeProgressView.alpha = 0.6;
        
        goalProgressView = [[LDProgressView alloc] initWithFrame:CGRectMake(0, frame.size.height-40, self.frame.size.width, 40)];
        goalProgressView.color = RGBColor(255, 215, 0);
        goalProgressView.showText = @NO;
        goalProgressView.flat = @YES;
        goalProgressView.progress = 0.0;
        goalProgressView.animate = @YES;
        goalProgressView.borderRadius = @5;
        [self addSubview:goalProgressView];
        
        //兔子场景
        rabbiter = [[RabbiterView alloc] initWithFrame:CGRectMake(100, frame.size.height-60-50, 40,70)];
        [self addSubview:rabbiter];
        
        //目标分数
        goalLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-110, frame.size.height-40+10, 100, 20)];
        goalLab.textAlignment = NSTextAlignmentRight;
        goalLab.textColor = [UIColor redColor];
        goalLab.text = [NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"目标", nil),[GameSetManager shareManager].grade];
        goalLab.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:goalLab];
        
        //得分lab
        gradeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-40+10, 100, 20)];
        gradeLab.textAlignment = NSTextAlignmentLeft;
        gradeLab.textColor = RGBColor(128, 42, 42);
        gradeLab.font = [UIFont boldSystemFontOfSize:14];
        gradeLab.text = [NSString stringWithFormat:@"%@:0",NSLocalizedString(@"得分", nil)];
        [self addSubview:gradeLab];
        
        //剩余时间
        timeLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 20)];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.text = [NSString stringWithFormat:@"%@:%ds",NSLocalizedString(@"时间", nil),GameTime];;
        timeLab.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:timeLab];
        timeLab.textColor = RGBColor(124, 252, 0);
        
        if ([GameSetManager shareManager].level % 2 == 1)//白天
        {
            NSInteger r = [Utils getRandomNumberBetween:0 to:255];
            NSInteger g = [Utils getRandomNumberBetween:0 to:255];
            NSInteger b = [Utils getRandomNumberBetween:0 to:255];
            
            NSInteger r1 = [Utils getRandomNumberBetween:0 to:255];
            NSInteger g1 = [Utils getRandomNumberBetween:0 to:255];
            NSInteger b1 = [Utils getRandomNumberBetween:0 to:255];
            
            NSInteger r2 = [Utils getRandomNumberBetween:0 to:255];
            NSInteger g2 = [Utils getRandomNumberBetween:0 to:255];
            NSInteger b2 = [Utils getRandomNumberBetween:0 to:255];
            
            sunImage.image = [UIImage imageNamed:@"sun.png"];
            
            UIColor *color = RGBColor(r,g,b);
            UIColor *color1 = RGBColor(r1,g1,b1);
            UIColor *color2 = RGBColor(r2,g2,b2);
//            self.backgroundColor = RGBColor(r,g,b);
            
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = self.frame;
            gradient.colors = [NSArray arrayWithObjects:(id)color.CGColor,
                               (id)color1.CGColor,
                               (id)color2.CGColor,nil];
            [self.layer insertSublayer:gradient atIndex:0];
        }
        else//黑夜
        {
            self.backgroundColor = [UIColor blackColor];
            sunImage.image = [UIImage imageNamed:@"moon.png"];
            timeLab.textColor = [UIColor whiteColor];
        }
        
        //暂停
        temporaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        temporaryBtn.frame = CGRectMake((self.frame.size.width-45)/2, frame.size.height-40, 45, 40);
        [temporaryBtn addTarget:self action:@selector(temporaryGame) forControlEvents:UIControlEventTouchUpInside];
        [temporaryBtn setBackgroundImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        [self addSubview:temporaryBtn];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(5, 5, 40, 40);
        [shareBtn addTarget:self action:@selector(shareApp) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [self addSubview:shareBtn];
        shareBtn.hidden = YES;
        
        //跳跃手势
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpTap)];
        [self addGestureRecognizer:tapGesture];
        
        //主计时器
        threadTimer = [NSTimer scheduledTimerWithTimeInterval:0.010
                                                       target:self
                                                     selector:@selector(sceneMainRunLoop)
                                                     userInfo:nil
                                                      repeats:YES];
        
        CDtimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(countDownTimer)
                                                     userInfo:nil
                                                      repeats:YES];
        
        start = NO;
        
        fruitArr = [[NSMutableArray alloc] init];
        cloundArr = [[NSMutableArray alloc] init];
        gledeArr = [[NSMutableArray alloc] init];
        
        curTime = GameTime;
    }
    
    return self;
}




//暂停游戏
- (void)temporaryGame
{
    if (start == YES)
    {
        start = NO;
        [temporaryBtn setBackgroundImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        
        [[MusicManager shareManager] pause];
        
        [self showBlurView];
    }
    else
    {
        start = YES;
        [temporaryBtn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
        [[MusicManager shareManager] play];
        
        [self dismissBlurView];
        
    }
}


#pragma mark 显示毛玻璃视图
- (void)showBlurView
{
    fxblurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [fxblurView addtemporaryOperateButton];
    [self addSubview:fxblurView];
    fxblurView.alpha = 0;
    
    __weak SceneView *weakSelf = self;
    
    [fxblurView setOperateBlk:^(NSInteger tag) {
        
        switch (tag)
        {
            case BlurOperate_restart:
            {
                [weakSelf restartGame];
                break;
            }
            case BlurOperate_choose:
            {
                [weakSelf choosePostAction];
                break;
            }
            case BlurOperate_continue:
            {
                [weakSelf temporaryGame];
                break;
            }
            case BlurOperate_share:
            {
                [GameSetManager shareManager].message = @"我正在玩《疯狂的兔子》，小伙伴们一起来疯狂吧！";
                [weakSelf shareApp];
                break;
            }
                
                
            default:
                break;
        }
        
    }];
    
    [fxblurView showBlurViewAnimationFinish:^{
        [self removeGestureRecognizer:tapGesture];
    }];
    
    /*
    //暂停画面
    blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [blurView addtemporaryOperateButton];
    [self addSubview:blurView];
    blurView.alpha = 0;
    
    __weak SceneView *weakSelf = self;
    
    [blurView setOperateBlk:^(NSInteger tag) {
        
        switch (tag)
        {
            case BlurOperate_restart:
            {
                [weakSelf restartGame];
                break;
            }
            case BlurOperate_choose:
            {
                [weakSelf choosePostAction];
                break;
            }
            case BlurOperate_continue:
            {
                [weakSelf temporaryGame];
                break;
            }
            case BlurOperate_share:
            {
                [weakSelf shareApp];
                break;
            }
                
                
            default:
                break;
        }
        
    }];
    
    [blurView showBlurViewAnimationFinish:^{
        [self removeGestureRecognizer:tapGesture];
    }];
     */
}

#pragma mark 隐藏毛玻璃
- (void)dismissBlurView
{
    [fxblurView dismissBlurViewAnimationFinish:^{
        
        [fxblurView removeFromSuperview];
        fxblurView = nil;
        
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpTap)];
        [self addGestureRecognizer:tapGesture];
        
    }];
}

#pragma mark 点击背景跳跃方法
- (void)jumpTap
{
    if (!start)
    {
        start = YES;
        
        [KProgressHUD showHUDWithText:NSLocalizedString(@"小兔子开始旅行了！", nil)];
        
        [CDtimer fire];
    }
    
    start = YES;
    
    maxJumpTime = MaxTime;
    
    //播放跳跃的声音
    [self playJumpSound];
    
    [temporaryBtn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [[MusicManager shareManager] play];
    
    [UIView animateWithDuration:0.3 animations:^{
        noteView.alpha = 0;
    } completion:^(BOOL finished) {
        [noteView removeFromSuperview];
    }];
}

#pragma mark 倒计时定时器
- (void)countDownTimer
{
    if (start)
    {
        curTime --;
        
        if (curTime <= 0)
        {
            curTime = 0;
        }
        
        timeLab.text = [NSString stringWithFormat:@"%@:%ds",NSLocalizedString(@"时间", nil),curTime];
        
        float curPro = curTime;
        
        float poffset = curPro/GameTime;
        
        timeProgressView.progress = poffset;
        
        [UIView animateWithDuration:1 animations:^{
            
            CGRect frame = sunImage.frame;
            
            if (sunImage.frame.origin.y == 10)
            {
                frame.origin.y = 50;
            }
            else
            {
                frame.origin.y = 10;
            }
            
            sunImage.frame = frame;
            
        }];
        
    }
}


#pragma mark 游戏住循环定时器
- (void)sceneMainRunLoop
{
    if (start)
    {
        //兔子跳跃
        [self rabbiterJumpAnimation];
        
        //随机生成云
        [self createCloundView];
        
        //随机生成水果和小鹰
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
    CGRect rect1 = bgView1.frame;
    rect1.origin.x -= 0.5;
    bgView1.frame = rect1;
    
    if (rect1.origin.x == -320)
    {
        rect1.origin.x = 320;
        bgView1.frame = rect1;
        
        railLab1.text = [NSString stringWithFormat:@"%d%@",[railLab2.text intValue]+10,NSLocalizedString(@"米", nil)];
        
        distance += 10;
        
        //随机替换树的图片
        NSInteger tmpY = [Utils getRandomNumberBetween:1 to:12];
        NSString *name = [NSString stringWithFormat:@"tree%d.png",tmpY];
        treeImage1.image = [UIImage imageNamed:name];
    }
    
    CGRect rect2 = bgView2.frame;
    rect2.origin.x -= 0.5;
    bgView2.frame = rect2;
    
    if (rect2.origin.x == -320)
    {
        rect2.origin.x = 320;
        bgView2.frame = rect2;
        
        railLab2.text = [NSString stringWithFormat:@"%d%@",[railLab1.text intValue]+10,NSLocalizedString(@"米", nil)];
        
        distance += 10;
        
        //随机替换树的图片
        NSInteger tmpY = [Utils getRandomNumberBetween:1 to:17];
        NSString *name = [NSString stringWithFormat:@"tree%d.png",tmpY];
        treeImage2.image = [UIImage imageNamed:name];
    }
    
    if (eatCount%10 == 0 &&  eatCount/10 > 0)
    {
        CGRect rect = rabbiter.frame;
        
        if (rect.size.width < 40 + eatCount/10 * 5)
        {
            [KProgressHUD showHUDWithText:NSLocalizedString(@"小兔子长大了!", nil)];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect rect = rabbiter.frame;
                rect.size.width = 40 + eatCount/10 * 5;
                rect.size.height = 70 + eatCount/10 * 5;
                rabbiter.frame = rect;
                
                [rabbiter growUp];
            }];
        }
    }
    
    if (curTime == 0 && eatCount < [GameSetManager shareManager].grade)
    {
        [self failToPlaygame:NSLocalizedString(@"时间用完了!", nil)];
    }
    else if (curTime >= 0 && eatCount >= [GameSetManager shareManager].grade)
    {
        [self successToPlaygame];
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

//随机生成水果和小鹰
- (void)createFruitView
{
    CGRect rect = fruitView.frame;
    rect.origin.x -= 0.5;
    fruitView.frame = rect;
    
    //随机生成小鹰
    if (gledePer == 100)
    {
        int hight = [UIScreen mainScreen].bounds.size.height - 53-30;
        NSInteger tmpY = [Utils getRandomNumberBetween:30 to:hight];
        
        int perY = tmpY/10;
        int yValue = perY*10;
        
        NSInteger glede = [Utils getRandomNumberBetween:1 to:10];
        
        UIImageView *gledeImage = [[UIImageView alloc] initWithFrame:CGRectMake(320 - rect.origin.x, yValue, 50, 50)];
        gledeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"glede%d.png",glede]];
        [fruitView addSubview:gledeImage];
        
        [gledeArr addObject:gledeImage];
        
        gledePer = 0;
    }
    
    gledePer ++;
    
    
    
    //随机生成水果
    if (fruitPer == 30)
    {
        int hight = [UIScreen mainScreen].bounds.size.height - 53-30;
        NSInteger tmpY = [Utils getRandomNumberBetween:30 to:hight];
        
        int perY = tmpY/10;
        int yValue = perY*10;
        
        //水果
        UIImageView *foodImage = [[UIImageView alloc] initWithFrame:CGRectMake(320 - rect.origin.x, yValue, 30, 30)];
        NSInteger imageId = [Utils getRandomNumberBetween:1 to:13];
        foodImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",imageId]];
        [fruitView addSubview:foodImage];
        
        [fruitArr addObject:foodImage];
        
        fruitPer = 0;
    }
    
    fruitPer ++;
}

//生成云
- (void)createCloundView
{
    CGRect rect = fruitView.frame;
    rect.origin.x -= 0.5;
    fruitView.frame = rect;
    
    if (fruitPer == 30)
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

#pragma mark 吃到食物或者碰到障碍物
//检测兔子是否碰到食物
- (void)checkHit
{
    [fruitArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *foodImage = (UIImageView *)obj;
        
        CGRect foodRect = foodImage.frame;
        
        CGRect rect = CGRectMake(foodRect.origin.x + fruitView.frame.origin.x, foodRect.origin.y, foodRect.size.width, foodRect.size.height);
        if (CGRectContainsPoint(rect,rabbiter.center))
        {
            [fruitArr removeObject:foodImage];
            
            //播放声音
            [self playFruitEatSound];
            
            eatCount ++;
            gradeLab.text = [NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"得分", nil),eatCount];
            
            float eatPro = eatCount;
            float pro = eatPro/[GameSetManager shareManager].grade;
            goalProgressView.progress = pro;            
            
            //分数抖动动画
            [AnimationEngin shakeAnimation:gradeLab repeatCount:4];
            
            CGPoint point = CGPointMake(-fruitView.frame.origin.x + 60, self.frame.size.height);
            
            //水果飞行动画
            [AnimationEngin flyAddSmallerAnimationToPoint:point withTime:1.0 withTime:foodImage];
            
            //吃到食物脉冲动画
            if (halo)
            {
                [halo removeFromSuperlayer];
            }
            
            NSInteger r = [Utils getRandomNumberBetween:0 to:255];
            NSInteger g = [Utils getRandomNumberBetween:0 to:255];
            NSInteger b = [Utils getRandomNumberBetween:0 to:255];
            
            halo = [PulsingHaloLayer layer];
            halo.position = rabbiter.center;
            halo.radius = 100;
            UIColor *color = RGBColor(r, g, b);
            halo.backgroundColor = color.CGColor;
            [self.layer insertSublayer:halo below:rabbiter.layer];
        }
        
        if (CGRectContainsPoint(CGRectMake(240, 0, 80, 80),rabbiter.center))
        {
            //播放声音
            [self playFruitEatSound];
            
            eatCount ++;
            gradeLab.text = [NSString stringWithFormat:@"得分:%d分",eatCount];
            
            //分数抖动动画
            [AnimationEngin shakeAnimation:gradeLab repeatCount:4];
            
            CGPoint point = CGPointMake(-fruitView.frame.origin.x + 60, self.frame.size.height);
            
            //水果飞行动画
            [AnimationEngin flyAddSmallerAnimationToPoint:point withTime:1.0 withTime:foodImage];
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
    
    //检测兔子是否碰到小鹰
    [gledeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView *gledeImage = (UIImageView *)obj;
        
        CGRect foodRect = gledeImage.frame;
        
        CGRect rect = CGRectMake(foodRect.origin.x + fruitView.frame.origin.x, foodRect.origin.y, foodRect.size.width, foodRect.size.height);
        
        if (CGRectContainsPoint(rect,rabbiter.center))
        {
            [self failToPlaygame:NSLocalizedString(@"失败了!", nil)];
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
        }
        
        //移除飘出屏幕的食物
        if (rect.origin.x + rect.size.width < 0)
        {
            [gledeArr removeObject:gledeImage];
            [gledeImage removeFromSuperview];
        }
    }];
}


#pragma mark 游戏失败
- (void)failToPlaygame:(NSString *)msg
{
    [threadTimer invalidate];
    threadTimer = nil;
    
    if (halo)
    {
        [halo removeFromSuperlayer];
    }
    
    start = NO;
    
    NSArray *arr = [NSArray arrayWithObjects:NSLocalizedString(@"选择关卡", nil),NSLocalizedString(@"重头再来", nil),nil];
    
    KIAlertView *alertView = [[KIAlertView alloc] initWithTitle:msg message:nil buttonTitleArr:arr event:^(NSInteger btnTag) {
        
        if (btnTag == 0)
        {
            BackToChooseBlk();
        }
        else
        {
            [self restartGame];
        }
    }];
    
    [alertView show];
    
    [self removeGestureRecognizer:tapGesture];
    
    [[MusicManager shareManager] stop];
    
    AudioServicesPlaySystemSound(1006);
    
    [UIView animateWithDuration:1.0 animations:^{
        
        CGRect rect = rabbiter.frame;
        rect.origin.y = self.frame.size.height - rect.size.height;
        rabbiter.frame = rect;
        
    }];
}

#pragma mark 游戏成功
- (void)successToPlaygame
{
    [threadTimer invalidate];
    threadTimer = nil;
    
    if (halo)
    {
        [halo removeFromSuperlayer];
    }
    
    start = NO;
    
    NSString *msg = [NSString stringWithFormat:@"小兔子吃了%d个水果,真棒~",eatCount];
    
    NSArray *arr = [NSArray arrayWithObjects:NSLocalizedString(@"再挑战一次", nil), NSLocalizedString(@"炫耀一下", nil),NSLocalizedString(@"下一关", nil), nil];
    
    NSString *title = [NSString stringWithFormat:@"%@%d %@",NSLocalizedString(@"关卡", nil),[GameSetManager shareManager].level,NSLocalizedString(@"挑战成功!", nil)];
    
    KIAlertView *alertView = [[KIAlertView alloc] initWithTitle:title message:nil buttonTitleArr:arr event:^(NSInteger btnTag) {
        
        switch (btnTag)
        {
            case 0:
            {
                [self restartGame];
                
                break;
            }
            case 1:
            {
                [GameSetManager shareManager].message = [NSString stringWithFormat:@"我在挑战“疯狂的兔子”第%d关，得到了%d分，你也来挑战一下吧！",[GameSetManager shareManager].level,eatCount];
                [self shareApp];
                
                break;
            }
            case 2:
            {
                [UIView animateWithDuration:2.0 animations:^{
                    
                    CGRect rect = rabbiter.frame;
                    rect.origin.x = self.frame.size.width;
                    rabbiter.frame = rect;
                    
                } completion:^(BOOL finished) {
                    
                    [GameSetManager shareManager].level += 1;
                    [GameSetManager shareManager].grade = [GameSetManager shareManager].level*10;
                    
                    [self restartGame];
                    
                }];
                
                break;
            }
                
                
            default:
                break;
        }
        
    }];
    
    [alertView show];
    
    [self removeGestureRecognizer:tapGesture];
    
    [[MusicManager shareManager] stop];
    
    [[MusicManager shareManager] playMusic:@"success.mp3"];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        CGRect rect = rabbiter.frame;
        rect.origin.y = self.frame.size.height-60-40;
        rabbiter.frame = rect;
        
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
    AudioServicesPlaySystemSound(1003);
}

//播放跳跃的声音
- (void)playJumpSound
{
    AudioServicesPlaySystemSound(1004);
}

- (void)restartGame
{
    RestartBlk();
}

- (void)choosePostAction
{
    BackToChooseBlk();
}

#pragma mark 分享
- (void)shareApp
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil)
                                                        message:NSLocalizedString(@"小康正在玩命开发中...", nil)
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"加油哦！", nil), nil];
    [alertView show];
    
    /*
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"tuzi"  ofType:@"png"];
    id<ISSCAttachment> imageAttach = [ShareSDK imageWithPath:imagePath];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[GameSetManager shareManager].message
                                       defaultContent:@""
                                                image:imageAttach
                                                title:NSLocalizedString(@"救命啊！", nil)
                                                  url:@"http://www.weibo.com"
                                          description:[GameSetManager shareManager].message
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                    
                                    [KProgressHUD showHUDWithText:@"分享成功"];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    
                                    [KProgressHUD showHUDWithText:[NSString stringWithFormat:@"分享失败:%@",[error errorDescription]]];
                                }
                            }];
     */
    
}


@end
