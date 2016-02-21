//
//  MulitfyManage.h
//  ILikeAssistant
//
//  Created by Pellet Mo on 15/12/3.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum __cfmsgID {
    GET_STSTS,
    WINDOW_SHOW,            //自用
    WINDOW_HIDE,            //自用
    APP_SHOW,
    APP_HIDE,
    SET_APP_MULTIFY,
    GET_APP_LIST,
    CHANGE_MODE,            //自用
} cfmsgID;


typedef enum __Enum_MultifyWindowStuts{
    STUTS_MULTIFY_USER,
    STUTS_MULTIFY_EDIT,
    STUTS_MULTIFY_SHOW,
}Enum_MultifyWindowStuts;


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define MULTIFYPORT   "xh.multify.port"

@interface MulitfyManage : NSObject
+(BOOL)mulitfy_check;
+(void)mulitfy_show;
+(void)mulitfy_hide;
+(void)mulitfy_set:(NSString *)appID :(double)width :(double)height :(double)rotation :(double)x :(double)y;
+(NSString *)mulitfy_list;
@end
