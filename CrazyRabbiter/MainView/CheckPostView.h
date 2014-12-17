//
//  CheckPostView.h
//  CrazyRabbiter
//
//  Created by 康起军 on 14/11/9.
//  Copyright (c) 2014年 康起军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckPostView : UIView

@property (copy, nonatomic) void (^ChoosePostBlk)(NSInteger tag);

@end
