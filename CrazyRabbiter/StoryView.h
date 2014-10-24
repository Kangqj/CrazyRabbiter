//
//  StoryView.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-10-22.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RabbiterView.h"

@interface StoryView : UIView
{
    RabbiterView  *rabbiter1;
    RabbiterView  *rabbiter2;
    UIImageView   *paopaoL;
    UIImageView   *paopaoR;
}

//翻页动画
@property (copy, nonatomic) void (^ StoryFinish)();

@end
