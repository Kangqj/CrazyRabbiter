//
//  KProgressHUD.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-10-20.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define AnimatehDuration 0.5
#define HUDStayTime      2
#define HUDTextFont      15
#define HUDyOffset       [UIScreen mainScreen].bounds.size.height - 400

@interface KProgressHUD : NSObject
{
    UIView *HUDView;
}

+ (KProgressHUD *)showHUDWithText:(NSString *)text;

@end
