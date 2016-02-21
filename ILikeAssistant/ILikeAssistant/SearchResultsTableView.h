//
//  SearchResultsTableView.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *resultArrays;
@end
