//
//  KeepTimer.m
//  Rememberword
//
//  Created by kang on 13-11-16.
//  Copyright (c) 2013年 com.KQJ.house. All rights reserved.
//

#import "KeepTimer.h"

@implementation KeepTimer

@synthesize m_delegate;
@synthesize startDate;

- (id)initWithDelegate:(id <KeepTimerDelegate>)delegate
{
    if (self = [super init])
    {
        self.m_delegate = delegate;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        self.startDate = [formatter dateFromString:@"00:00:00"];
        
        count = 0;
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(keepTime) userInfo:nil repeats:YES];
        [self stopTimer];
    }
    
    return self;
}

//开启
- (void)startTimer
{
    [timer setFireDate:[NSDate distantPast]];
}

//暂停
- (void)stopTimer
{
    [timer setFireDate:[NSDate distantFuture]];
}

//计时方法
- (void)keepTime
{
    count++;
    
    NSDate *date = [self.startDate addTimeInterval:count];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *newTime = [formatter stringFromDate:date];
    
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(newTimeDataWith:)])
    {
        [m_delegate newTimeDataWith:newTime];
    }
    
    if (count % (15*60) == 0 && count != 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已用时newTime" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
}

//销毁
- (void)revokeTimer
{
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

@end
