//
//  GameSetManager.m
//  CrazyRabbiter
//
//  Created by 康起军 on 14/11/12.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import "GameSetManager.h"

static GameSetManager *manager = nil;

@implementation GameSetManager

@synthesize level, grade, message;

+ (GameSetManager *)shareManager
{
    if (!manager) {
        
        manager = [[GameSetManager alloc] init];
        
    }
    
    return manager;
}

- (id)init
{
    if (self)
    {
        self = [super init];
        
        level = 1;
        grade = 10;
    }
    
    return self;
}


@end

