//
//  RabbiterView.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "RabbiterView.h"

@implementation RabbiterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
//        self.backgroundColor = [UIColor redColor];
        
        rabbiterHeaderImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        rabbiterHeaderImage.image = [UIImage imageNamed:@"tuzi.png"];
        [self addSubview:rabbiterHeaderImage];
    }
    
    return self;
}

- (void)changeRabbiterHeaderImage:(UIImage *)image
{
    rabbiterHeaderImage.image = image;
}

- (void)growUp
{
    CGRect rect = rabbiterHeaderImage.frame;
    rect.size.width = self.frame.size.width;
    rect.size.height = self.frame.size.height;
    rabbiterHeaderImage.frame = rect;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    startPoint = [[touches anyObject] locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint movePoint = [[touches anyObject] locationInView:self.superview];
    
    CGRect rect = self.frame;
    rect.origin.x = movePoint.x - startPoint.x;
//    rect.origin.y = movePoint.y - startPoint.y;
    self.frame = rect;
    
}

@end
