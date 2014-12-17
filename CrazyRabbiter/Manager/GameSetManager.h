//
//  GameSetManager.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14/11/12.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSetManager : NSObject
{
    NSInteger level;
    NSInteger grade;
}

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger grade;
@property (strong, nonatomic) NSString   *message;

+ (GameSetManager *)shareManager;

@end
