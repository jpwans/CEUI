//
//  AppDelegate.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataType.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  全局数组
 */
@property(strong ,nonatomic) NSMutableArray * globalArrays;

@property(strong ,nonatomic) NSArray * globalDataTypeArrays;


@property(assign ,nonatomic) NSUInteger defaultIndex;

/**
 *  当前界面的appid
 */
@property(strong,nonatomic) NSString *appid;

/**
 *  当前旋转角度
 */
@property(assign,nonatomic) double  rotation;


@end

