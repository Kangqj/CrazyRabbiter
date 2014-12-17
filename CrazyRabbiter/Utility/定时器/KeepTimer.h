//
//  KeepTimer.h
//  Rememberword
//
//  Created by kang on 13-11-16.
//  Copyright (c) 2013年 com.KQJ.house. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeepTimerDelegate <NSObject>

- (void)newTimeDataWith:(NSString *)time;

@end

@interface KeepTimer : NSObject
{
    NSTimer      *timer;
    NSDate       *startDate;
    NSInteger    count;
    
    __weak id <KeepTimerDelegate> m_delegate;
}

@property (retain, nonatomic) NSDate        *startDate;

@property (weak) id <KeepTimerDelegate> m_delegate;

- (id)initWithDelegate:(id <KeepTimerDelegate>)delegate;

- (void)startTimer;

- (void)stopTimer;

- (void)revokeTimer;

@end
