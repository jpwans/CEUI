//
//  Define.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#ifndef ILikeAssistant_Define_h
#define ILikeAssistant_Define_h


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//软键盘高度
#define KEYBOARD_HEIGHT 216.0f
//状态栏高度
#define STATUS_HEIGHT 20.0f
//[[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define NAVIGATION_HEIGHT  44.0f
//(self.navigationController.navigationBar.frame.size.height)
//tabBar高度
#define BUTTOMBAR_HEIGHT 49.0f
//(self.tabBarController.tabBar.frame.size.height)

//默认采色
#define THEME_COLOR [UIColor colorWithRed:230.0/255.0 green:80.0/255.0 blue:78.0/255.0 alpha:1.0] //主题色
#define BACKGROUND_COLOR  [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0] //背景色
#define LINE_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6] 
//设置系统字体大小
#define SystemFont(size) [UIFont systemFontOfSize:(size)];
#define ShareAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define NotificationCenter [NSNotificationCenter defaultCenter]
#define Notif_SendValue @"sendValue"
#define Notif_DidSelected @"didSelected"
#define Notif_DidSelectedToAlert @"didSelectedToAlert"
#define Notif_EmptyToDropDown @"emptyToDropDown"
#define Notif_Confirm @"confirm"
#define Notif_DidSelectedToDataType @"didSelectedToDataType"
#define SingleOffset  4
//RGB颜色转换（16进制->10进制）
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ShareAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define defaultFontSize SystemFont(14)  //结果字体大小
#define KMargin 8
#endif
