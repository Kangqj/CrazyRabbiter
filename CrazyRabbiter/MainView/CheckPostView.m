//
//  CheckPostView.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14/11/9.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "CheckPostView.h"

@implementation CheckPostView

@synthesize ChoosePostBlk;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = RGBColor(150, 206, 35);
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        titleLab.text = @"关卡";
        titleLab.textColor = [UIColor magentaColor];
        titleLab.textAlignment = UITextAlignmentCenter;
        titleLab.font = [UIFont boldSystemFontOfSize:25];
        [self addSubview:titleLab];
        
        for (int i = 0; i< 28; i++)
        {
            UIView *postView = [[UIView alloc] initWithFrame:CGRectMake(14 + 60*(i%5), 80 + 70*(i/5), 50, 50)];
//            postView.backgroundColor = [UIColor purpleColor];
//            postView.layer.cornerRadius = 5;
            [self addSubview:postView];
            
            NSString *imageName = [NSString stringWithFormat:@"paopao%d.png",i%2];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 50, 50);
            [btn addTarget:self action:@selector(chooseThisPost:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            btn.tag = i+1;
            [postView addSubview:btn];
            
            UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            nameLab.text = [NSString stringWithFormat:@"%d",i+1];
            nameLab.textColor = [UIColor whiteColor];
            nameLab.textAlignment = UITextAlignmentCenter;
            nameLab.font = [UIFont boldSystemFontOfSize:15];
            [btn addSubview:nameLab];
        }
    }
    
    return self;
}

- (void)chooseThisPost:(UIButton *)btn
{
    ChoosePostBlk(btn.tag);
}

@end
