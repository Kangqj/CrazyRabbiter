//
//  GlobalDefine.h
//  EMIT
//
//  Created by Zhu Gang on 3/12/14.
//  Copyright (c) 2014 MobileReal. All rights reserved.
//

#import "KProgressHUD.h"

#ifndef EMIT_GlobalDefine_h
#define EMIT_GlobalDefine_h

#define ImageWithName(name)\
[UIImage imageNamed:name]

#define AlertMessage(tipMsg)    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:\
tipMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alertView show];\

#define kMainScreenFrameRect        [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define kMainScreenWidth            kMainScreenFrameRect.size.width
//设备屏幕高度
#define kMainScreenHeight           kMainScreenFrameRect.size.height


#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define g_App ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define RGBAColor(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]
#define RGBColor(r, g, b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBColorFromHEX(value)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define iOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define iPhone5 [UIScreen mainScreen].scale == 2.f && [UIScreen mainScreen].bounds.size.height == 568.0f
#define iPad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define kSrcName(file) [kBundleName stringByAppendingPathComponent:file]
#define safeObjectValue(object, key) [object objectForKey:key]== nil ? @"" : [NSString stringWithFormat:@"%@", [object objectForKey:key]]

#define kGoldenColor RGBAColor(193, 157, 110, 255)

#define COLOR_BG        UIColorFromRGB(0xffffff)
//安全释放
#define RELEASE_SAFELY(__REF) { if (nil != (__REF)) { [(__REF) release]; __REF = nil; } }
#define AUTORELEASE_SAFELY(__REF) { if (nil != (__REF)) { [(__REF) autorelease]; __REF = nil; } }


#define JX_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height-20
#define JX_SCREEN_WIDTH 600//[[UIScreen mainScreen] bounds].size.width
#define MY_USER_ID [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]



#endif
