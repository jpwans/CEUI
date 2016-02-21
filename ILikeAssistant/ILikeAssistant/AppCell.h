//
//  AppCell.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"
@interface AppCell : UITableViewCell



@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *appNameLable;

-(void)settingData:(AppInfo *)appInfo ;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
