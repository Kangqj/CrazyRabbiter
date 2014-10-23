//
//  StoryView.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-10-22.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "StoryView.h"

@implementation StoryView

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
        
    }];
}

//大树和栏杆飞出
- (void)showTreeAndRailImageView
{
    UIImageView *treeImage = [[UIImageView alloc] initWithFrame:CGRectMake(-150, self.frame.size.height-260, 150,230)];
    treeImage.image = [UIImage imageNamed:@"tree.png"];
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
    UIImageView *paopaoL = [[UIImageView alloc] initWithFrame:CGRectMake(40, 430, 100,50)];
    paopaoL.image = [UIImage imageNamed:@"paopao_L.png"];
    [self addSubview:paopaoL];
    paopaoL.alpha = 0;
    
    UILabel *label_L = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label_L.textAlignment = UITextAlignmentCenter;
    label_L.font = [UIFont systemFontOfSize:12];
    label_L.text = @"我们一起去玩吧";
    label_L.textColor = [UIColor blueColor];
    label_L.backgroundColor = [UIColor clearColor];
    [paopaoL addSubview:label_L];
    
    [self performSelector:@selector(showPaopao:) withObject:paopaoL afterDelay:2];
    
    UIImageView *paopaoR = [[UIImageView alloc] initWithFrame:CGRectMake(120, 430, 100,50)];
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
    
    [self performSelector:@selector(showPaopao:) withObject:paopaoR afterDelay:5.5];
}


//现实泡泡
- (void)showPaopao:(UIImageView *)paopao
{
    [UIView animateWithDuration:0.5 animations:^{
        
        paopao.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(dissmissPaopao:) withObject:paopao afterDelay:3];
        
    }];
}


//泡泡消失
- (void)dissmissPaopao:(UIImageView *)paopao
{
    [UIView animateWithDuration:0.5 animations:^{
        
        paopao.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [paopao removeFromSuperview];
        
        [self performSelector:@selector(showTwoRabbiterToghter) withObject:nil afterDelay:1];
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
    }];
}


@end
