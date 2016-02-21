//
//  SearchResultCell.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResults.h"
@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *resultNo;
@property (weak, nonatomic) IBOutlet UILabel *memoryLable;
@property (weak, nonatomic) IBOutlet UILabel *valueLable;
@property (weak, nonatomic) IBOutlet UILabel *charTypeLable;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *describeLable;

-(void)settingData:(SearchResults *)searchResults  indexPath:(NSIndexPath *)indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
