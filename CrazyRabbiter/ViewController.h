//
//  ViewController.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14-9-27.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneView.h"
#import "StoryView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CheckPostView.h"

@interface ViewController : UIViewController
{
    SceneView     *sceneView;//游戏主视图
    StoryView     *stroyView;//故事剧情视图
    CheckPostView *checkView;//关卡选择视图
}

- (void)temporaryPlayGame;

@end
