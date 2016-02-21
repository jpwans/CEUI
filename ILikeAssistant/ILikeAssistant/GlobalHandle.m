//
//  GlobalHandle.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "GlobalHandle.h"

@implementation GlobalHandle
+(id)sharedInstance{

    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GlobalHandle alloc] init];
    });
    return sharedInstance;
}

@end
