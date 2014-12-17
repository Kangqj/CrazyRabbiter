//
//  StoryView.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-10-22.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RabbiterView.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface StoryView : UIView
{
    RabbiterView  *rabbiter1;
    RabbiterView  *rabbiter2;
    UIImageView   *paopaoL;
    UIImageView   *paopaoR;
    UIImageView   *sunImage;
    UIImageView   *gledeImage;
    UIImageView   *cloundImage;
    CALayer       *gledeLayer;
}

//翻页动画
@property (copy, nonatomic) void (^ StoryFinish)();

@end
