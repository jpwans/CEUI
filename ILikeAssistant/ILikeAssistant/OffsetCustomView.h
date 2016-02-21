//
//  OffsetCustomView.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/29.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffsetCustomView : UIView<UITextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)frame :(NSString*)groupId :(NSUInteger)index :(id)observer;
@end
