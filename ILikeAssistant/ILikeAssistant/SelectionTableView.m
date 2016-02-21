//
//  SelectionTableView.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "SelectionTableView.h"
#import "SearchResults.h"
#import "SearchResultCell.h"
@implementation SelectionTableView

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
    return ShareAppDelegate.globalArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResults *SearchResults = ShareAppDelegate.globalArrays[indexPath.row];
    SearchResultCell *cell = [SearchResultCell cellWithTableView:tableView];
    [cell settingData:SearchResults indexPath:indexPath];
    
    [cell.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = indexPath.row;
    
    return cell;
}

/**
 *删除
 */
-(void)deleteAction:(UIButton *)button{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    [ShareAppDelegate.globalArrays removeObjectAtIndex:indexPath.row];
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SearchResults *SearchResults = _resultArrays[indexPath.row];
    NSLog(@"SelectionTableView:%ld",(long)indexPath.row);
    SearchResults *searchResults = ShareAppDelegate.globalArrays[indexPath.row];
    NSMutableDictionary * dictionary = [NSMutableDictionary new];
    [dictionary setObject:searchResults forKey:@"SearchResults"];
    [dictionary setObject:indexPath forKey:@"NSIndexPath"];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notif_DidSelectedToAlert object:self userInfo:dictionary];
}



@end
