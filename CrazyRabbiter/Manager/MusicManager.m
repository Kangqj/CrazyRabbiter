//
//  MusicManager.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14/11/10.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "MusicManager.h"

static MusicManager *manager = nil;

@implementation MusicManager

+ (MusicManager *)shareManager
{
    if (!manager) {
        
        manager = [[MusicManager alloc] init];
        
    }
    
    return manager;
}

- (id)init
{
    if (self)
    {
        self = [super init];
    }
    
    return self;
}

- (void)playMusic:(NSString *)name
{
//    return;
    
    NSArray *arr = [name componentsSeparatedByString:@"."];
    
    if ([arr count] < 2)
    {
        return;
    }
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:[arr objectAtIndex:0] ofType:[arr objectAtIndex:1]];
    
//    if (musicPath == nil)
//    {
//        return;
//    }
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
    
    if (player)
    {
        [player stop];
        player = nil;
    }
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [player prepareToPlay];
    player.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
    [player play];
}

- (void)play
{
//    return;
    [player play];
}

- (void)stop
{
//    return;
    [player stop];
}

- (void)pause
{
//    return;
    [player pause];
}


@end
