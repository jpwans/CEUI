//
//  SearchResultCell.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "SearchResultCell.h"
#import "DataType.h"
@implementation SearchResultCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    CGRect frame = self.frame;
    self.frame = frame;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(10.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
    bottomBorder.backgroundColor = LINE_COLOR.CGColor;
    [self.layer addSublayer:bottomBorder];
    
    [_deleteButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    _deleteButton.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)settingData:(SearchResults *)searchResults  indexPath:(NSIndexPath *)indexPath{
    
    [_resultNo setText:[NSString stringWithFormat:@"%d",(int)indexPath.row +1]];
    [_memoryLable setText:searchResults.memoryAddress];
    [_valueLable setText:searchResults.searchValue];

  
    
    [_charTypeLable setText:  [ShareAppDelegate.globalDataTypeArrays objectAtIndex:searchResults.dataType.dataIndex]];
    [_describeLable setText:searchResults.describe.length?searchResults.describe:@"无描述"];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SearchResultCell";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
