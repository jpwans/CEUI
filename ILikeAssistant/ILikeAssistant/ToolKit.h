//
//  ToolKit.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/28.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolKit : NSObject
+ (UIImage *)createImageWithColor:(UIColor *)color;
+(UIButton *)createCustomButton;
/**
 *十进制转十六进制
 */
+(NSString *) stringWith :(int )single;
@end
