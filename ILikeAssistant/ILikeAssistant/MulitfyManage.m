//
//  MulitfyManage.m
//  ILikeAssistant
//
//  Created by Pellet Mo on 15/12/3.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "MulitfyManage.h"
#import "PrivateApiHeader.h"
@implementation MulitfyManage
+(BOOL)mulitfy_check{
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(MULTIFYPORT));
    if (nil == bRemote){
        return NO;
    }
    else{
        CFMessagePortInvalidate(bRemote);
        return YES;
    }
    
}

+(void)mulitfy_show{
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(MULTIFYPORT));
    if (nil == bRemote) {
        NSLog(@"bRemote create failed");
    }
    CFDataRef data = CFDataCreate(NULL, nil, 0);
    CFDataRef recvData = nil;
    CFMessagePortSendRequest(bRemote, APP_SHOW, data, 0, 100 , kCFRunLoopDefaultMode, &recvData);
    
    CFRelease(data);
    CFMessagePortInvalidate(bRemote);
    CFRelease(bRemote);
}

+(void)mulitfy_hide{
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(MULTIFYPORT));
    if (nil == bRemote) {
        NSLog(@"bRemote create failed");
        return;
    }
    CFDataRef data = CFDataCreate(NULL, nil, 0);
    CFDataRef recvData = nil;
    CFMessagePortSendRequest(bRemote, APP_HIDE, data, 0, 100 , kCFRunLoopDefaultMode, &recvData);
    
    CFRelease(data);
    CFMessagePortInvalidate(bRemote);
    CFRelease(bRemote);
    
}

+(void)mulitfy_set:(NSString *)appID :(double)width :(double)height :(double)rotation :(double)x :(double)y{
    
    //    NSString* appID = [NSString stringWithCString:luaL_checkstring(L,1) encoding:NSUTF8StringEncoding];
    
    int ret = SBSLaunchApplicationWithIdentifier(appID, 1);
    if (ret != 0) {
        CFStringRef errmsg = SBSApplicationLaunchingErrorString(ret);
        NSLog(@"run %@ error:%s\n",appID,[(id)CFBridgingRelease(errmsg) UTF8String]);
        return;
    }else
        NSLog(@"run app successfully \n");
    
    NSString *msg = [NSString stringWithFormat:@"%@|%f|%f|%f|%f|%f",
                     appID,
                     width,
                     height,
                     rotation,
                     x,
                     y];
    NSLog(@"send msg is :%@",msg);
    
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(MULTIFYPORT));
    if (nil == bRemote) {
        NSLog(@"bRemote create failed");
        return;
    }
    const char* message = [msg UTF8String];
    CFDataRef data = CFDataCreate(NULL, (UInt8*)message, strlen(message));
    CFDataRef recvData = nil;
    CFMessagePortSendRequest(bRemote, SET_APP_MULTIFY, data, 0, 100 , kCFRunLoopDefaultMode, &recvData);
    CFRelease(data);
    CFMessagePortInvalidate(bRemote);
    CFRelease(bRemote);
}

+(NSString *)mulitfy_list{
    CFMessagePortRef bRemote = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(MULTIFYPORT));
    if (nil == bRemote) {
        NSLog(@"bRemote create failed");
        return @"";
    }
    CFDataRef data = CFDataCreate(NULL, nil, 0);
    CFDataRef recvData = nil;
    CFMessagePortSendRequest(bRemote, GET_APP_LIST, data, 0, 100 , kCFRunLoopDefaultMode, &recvData);
    CFRelease(data);
    CFMessagePortInvalidate(bRemote);
    CFRelease(bRemote);
    
    if (recvData == nil) {
        return @"";
    }
    
    const UInt8* recvedMsg = CFDataGetBytePtr(recvData);
    if (recvedMsg == nil) {
        return @"";
    }
    
    NSString* recv = [NSString stringWithCString:(char *)recvedMsg encoding:NSUTF8StringEncoding];
    return recv;
}

@end
