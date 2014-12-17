//
//  RabbiterView.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RabbiterView : UIView
{
    UIImageView *rabbiterHeaderImage;
    
    CGPoint startPoint;
}

- (void)changeRabbiterHeaderImage:(UIImage *)image;

- (void)growUp;

@end
