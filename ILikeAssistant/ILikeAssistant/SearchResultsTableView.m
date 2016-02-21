//
//  SearchResultsTableView.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "SearchResultsTableView.h"
#import "SearchResultsTableViewCell.h"
@implementation SearchResultsTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource =self;
        self.delegate=self;
        self. separatorStyle =UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
    }
    return self;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResults *SearchResults = _resultArrays[indexPath.row];
    SearchResultsTableViewCell *cell = [SearchResultsTableViewCell cellWithTableView:tableView];
    [cell settingData:SearchResults indexPath:indexPath];

    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //点击把值传到 SelectionTableView  并刷新  SelectionTableView
    [ShareAppDelegate.globalArrays addObject:_resultArrays[indexPath.row]];
    [NotificationCenter  postNotificationName:Notif_DidSelected object:nil];

}


@end
