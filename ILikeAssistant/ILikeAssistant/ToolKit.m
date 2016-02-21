//
//  ToolKit.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/28.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "ToolKit.h"

@implementation ToolKit
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+(UIButton *)createCustomButton{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = NO;
    button.layer.cornerRadius = 6;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor blackColor].CGColor;
[button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    return button;

}

+(NSString *) stringWith :(int )single{
    NSString *temp = [NSString new];
    if (single>=0 ) {
        temp = [[NSString alloc] initWithFormat:@"%1x",single];

    }
    else{
        single = -single;
        temp = [[NSString alloc] initWithFormat:@"-%1x",single];

    }
    return temp  ;
}
@end
