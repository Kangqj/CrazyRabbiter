//
//  ViewController.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    sceneView = [[SceneView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    sceneView.alpha = 0;
    
    stroyView = [[StoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:stroyView];
    
    __weak ViewController *weakSelf = self;
    __weak SceneView      *weakSceneView = sceneView;
    __weak StoryView      *weakStroyView = stroyView;
    
    [stroyView setStoryFinish:^{
        
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:weakSelf.view cache:YES];
        
        [weakStroyView removeFromSuperview];
        [weakSelf.view addSubview:weakSceneView];
        
        [UIView commitAnimations];
        
        [weakSelf performSelector:@selector(showSceneView) withObject:nil afterDelay:1.0];
    }];
}

//显示场景视图
- (void)showSceneView
{
    [UIView animateWithDuration:2 animations:^{
        sceneView.alpha = 1.0;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
