//
//  ViewController.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *musicArr;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    musicArr = [[NSArray alloc] initWithObjects:@"chaojimali.mp3",@"huoying.mp3",@"bgmusic.mp3", nil];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isFinish = [userDefaults boolForKey:isStoryFinish];
    
    if (isFinish)//播放过剧情
    {
        //选关页面
        [self initCheckPostView];
    }
    else//未播放过剧情
    {
        stroyView = [[StoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:stroyView];
        
        __weak StoryView      *weakStroyView = stroyView;
        __weak ViewController *weakSelf = self;
        __block ViewController *blockSelf = self;
        
        [weakSelf initSceneView];
        
        __weak SceneView *weakSceneView = blockSelf->sceneView;
        
        //游戏页面跳入选关页面
        [blockSelf->sceneView setBackToChooseBlk:^{
            
            [self initCheckPostView];
            
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:weakSelf.view cache:YES];
            
            [weakSceneView removeFromSuperview];
            
            [UIView commitAnimations];
            
        }];
        
        //故事页面跳入游戏页面
        [stroyView setStoryFinish:^{
            
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:weakSelf.view cache:YES];
            
            [weakStroyView removeFromSuperview];
            [weakSelf.view addSubview:blockSelf->sceneView];
            
            NSInteger index = [Utils getRandomNumberBetween:0 to:2];
            [[MusicManager shareManager] playMusic:[blockSelf->musicArr objectAtIndex:index]];
            
            [UIView commitAnimations];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:YES forKey:isStoryFinish];
            [userDefaults synchronize];
        }];
    }
}

//初始化选关页面
- (void)initCheckPostView
{
    __weak ViewController *weakSelf = self;
    __block ViewController *blockSelf = self;
    
    blockSelf->checkView = [[CheckPostView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:checkView];
    
    [checkView setChoosePostBlk:^(NSInteger row) {
        
        [GameSetManager shareManager].level = row;
        [GameSetManager shareManager].grade = [GameSetManager shareManager].level*10;
        
        //初始化游戏视图
        [weakSelf initSceneView];
        
        __weak SceneView *weakSceneView = blockSelf->sceneView;
        
        //游戏页面跳入选关页面
        [blockSelf->sceneView setBackToChooseBlk:^{
            
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:weakSelf.view cache:YES];
            
            [weakSceneView removeFromSuperview];
            
            [UIView commitAnimations];
            
        }];
        
        //翻页从选关页面进入游戏页面
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:weakSelf.view cache:YES];
        
        [weakSelf.view addSubview:blockSelf->sceneView];
        
        NSInteger index = [Utils getRandomNumberBetween:0 to:2];
        [[MusicManager shareManager] playMusic:[blockSelf->musicArr objectAtIndex:index]];
        
        [UIView commitAnimations];
        
    }];
}

//初始化游戏视图
- (void)initSceneView
{
    __weak ViewController *weakSelf = self;
    __block ViewController *blockSelf = self;
    
    blockSelf->sceneView = [[SceneView alloc] initWithFrame:CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height)];
    
    //重新开始游戏
    [blockSelf->sceneView setRestartBlk:^{
        
        [weakSelf restartGame];
        
    }];
}


//重新开始比赛
- (void)restartGame
{
    if (sceneView)
    {
        [sceneView removeFromSuperview];
        sceneView = nil;
    }
    
    sceneView = [[SceneView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:sceneView];
    
    __block ViewController *blockSelf = self;
    NSInteger index = [Utils getRandomNumberBetween:0 to:2];
    [[MusicManager shareManager] playMusic:[blockSelf->musicArr objectAtIndex:index]];
    
    __weak ViewController  *weakSelf = self;
    __weak SceneView      *weakSceneView = sceneView;
    
    [sceneView setRestartBlk:^{
        
        [weakSelf restartGame];
        
    }];
    
    //游戏页面跳入选关页面
    [sceneView setBackToChooseBlk:^{
        
        [weakSelf initCheckPostView];
        
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:weakSelf.view cache:YES];
        
        [weakSceneView removeFromSuperview];
        
        [UIView commitAnimations];
        
    }];
}

- (void)temporaryPlayGame
{
    [sceneView temporaryGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
