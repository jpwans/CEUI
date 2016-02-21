//
//  PrivateApiHeader.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/25.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#ifndef ILikeAssistant_PrivateApiHeader_h
#define ILikeAssistant_PrivateApiHeader_h


#import <Foundation/Foundation.h>
#import <mach/mach.h>

int SBSLaunchApplicationWithIdentifier (NSString* identifier, BOOL b);
void SBSProcessIDForDisplayIdentifier (NSString* identifier, int* pid);
void* SBFrontmostApplicationDisplayIdentifier (mach_port_t port,char * result);
int SBSSpringBoardServerPort (void);
CFStringRef SBSApplicationLaunchingErrorString(int error);
kern_return_t mach_port_deallocate (ipc_space_t task, mach_port_name_t name);

NSArray* SBSCopyApplicationDisplayIdentifiers(mach_port_t * port, BOOL runningApps,BOOL debuggablet);//获取A正在运行APP列表
NSString * SBSCopyLocalizedApplicationNameForDisplayIdentifier(NSString*  bundleId);//获取器APP名称
NSData* SBSCopyIconImagePNGDataForDisplayIdentifier(NSString * bundleid);//获取APP图标
#endif



