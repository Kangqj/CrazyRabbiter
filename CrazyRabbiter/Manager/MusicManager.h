//
//  MusicManager.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14/11/10.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicManager : NSObject
{
    AVAudioPlayer  *player;
}

+ (MusicManager *)shareManager;

- (void)playMusic:(NSString *)name;

- (void)play;
- (void)stop;
- (void)pause;

@end
