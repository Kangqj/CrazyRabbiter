//
//  SceneView.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RabbiterView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DRNRealTimeBlurView.h"
#import "FXBlurView.h"

@interface SceneView : UIView
{
    RabbiterView *rabbiter; //主角
    
    NSTimer      *threadTimer;
    
    NSInteger    eatCount; //吃到水果的数量
    NSInteger    distance; //跑的距离
    
    NSInteger    fruitPer; //食物生成速率
    NSInteger    gledePer; //小鹰生成速率
    
    float maxJumpTime; //跳跃时间
    
    NSMutableArray *fruitArr;   //食物集合
    NSMutableArray *cloundArr;  //云集合
    NSMutableArray *gledeArr;   //鹰集合
    
    UIView         *fruitView;  //水果漂浮父视图
    UITextView     *noteView;   //通知视图
    
    UILabel        *gradeLab;   //得分
    UILabel        *goalLab;    //目标
    UILabel        *timeLab;    //倒计时
    
    UIView         *bgView1;//滚动背景界面1
    UIView         *bgView2;//滚动背景界面2
    
    UIImageView    *treeImage1;
    UIImageView    *treeImage2;
    
    UILabel        *railLab1;//栏杆1牌子文字
    UILabel        *railLab2;//栏杆2牌子文字
    
    UIButton       *temporaryBtn;//暂停
    
    BOOL    start;//游戏状态
    
    UITapGestureRecognizer *tapGesture;//点击跳跃手势
    
//    DRNRealTimeBlurView *blurView; //毛玻璃效果
    FXBlurView          *fxblurView;
    
    PulsingHaloLayer *halo;    //脉冲效果
    
    NSTimer        *CDtimer;   //倒计时
    NSInteger      curTime;    //当前时间
    
    UIImageView    *sunImage; //太阳
}

@property (copy, nonatomic) void (^ RestartBlk)();
@property (copy, nonatomic) void (^ BackToChooseBlk)();

- (void)temporaryGame;

@end
