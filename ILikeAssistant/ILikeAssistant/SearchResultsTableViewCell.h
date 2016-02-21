//
//  SearchResultsTableViewCell.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResults.h"
@interface SearchResultsTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *addressLable;
@property(nonatomic,strong)UILabel *searchValueLable ;
@property(nonatomic,strong) UILabel *previousValueLable;
-(void)settingData:(SearchResults *)searchResults  indexPath:(NSIndexPath *)indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
