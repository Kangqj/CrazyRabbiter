//
//  SceneView.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RabbiterView.h"

@interface SceneView : UIView
{
    RabbiterView *rabbiter;
    
    NSTimer      *threadTimer;
    
    NSInteger    timerCount;
    NSInteger    eatCount;
    
    BOOL    start;
    
    //跳跃时间
    float maxJumpTime;
    
    NSMutableArray *fruitArr;
    NSMutableArray *cloundArr;
    
    UIView         *fruitView;
    UILabel        *gradeLab;
    
    UIImageView    *railImage1;
    UIImageView    *railImage2;
    
    UILabel        *railLab1;
    UILabel        *railLab2;
}

@end
