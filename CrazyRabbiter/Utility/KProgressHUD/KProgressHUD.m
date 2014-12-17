//
//  KProgressHUD.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-10-20.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "KProgressHUD.h"

@implementation KProgressHUD

+ (KProgressHUD *)showHUDWithText:(NSString *)text
{
    KProgressHUD *HUD = [[KProgressHUD alloc] initWithText:text];
    
    [HUD showAnimation];
    
    return HUD;
}


- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        NSArray *windows = [UIApplication sharedApplication].windows;
        UIWindow *window = [windows objectAtIndex:0];
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:HUDTextFont] constrainedToSize:CGSizeMake(300, 40)];
        
        HUDView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width+10, 40)];
        HUDView.backgroundColor = [UIColor blackColor];
        HUDView.center = CGPointMake(160, HUDyOffset);
        HUDView.layer.cornerRadius = 8;
        [window.rootViewController.view addSubview:HUDView];
        HUDView.alpha = 0;
        
        UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HUDView.frame.size.width, HUDView.frame.size.height)];
        textLab.text = text;
        textLab.font = [UIFont boldSystemFontOfSize:HUDTextFont];
        textLab.textColor = [UIColor whiteColor];
        textLab.backgroundColor = [UIColor clearColor];
        textLab.center = CGPointMake(HUDView.frame.size.width/2, HUDView.frame.size.height/2);
        textLab.textAlignment = UITextAlignmentCenter;
        textLab.numberOfLines = 0;
        [HUDView addSubview:textLab];
        
    }
    
    return self;
}


- (void)showAnimation
{
    [UIView animateWithDuration:AnimatehDuration animations:^{
        
        HUDView.alpha = 0.7;
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(dissmissHUD) withObject:nil afterDelay:HUDStayTime];
        
    }];
}


- (void)dissmissHUD
{
    [UIView animateWithDuration:AnimatehDuration animations:^{
        
        HUDView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [HUDView removeFromSuperview];
        
    }];
}


@end
