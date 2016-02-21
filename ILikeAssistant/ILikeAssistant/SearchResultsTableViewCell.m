//
//  SearchResultsTableViewCell.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "SearchResultsTableViewCell.h"

@implementation SearchResultsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        CGRect frame =CGRectMake(0, 0, SCREEN_WIDTH*0.3, 25);
        self.frame = frame;
      
        
        CGFloat magin =  8;
        CGFloat addressLableX = magin;
        CGFloat lableY = (self.frame.size.height -20)/2;
        CGFloat lableW = 75;
        CGFloat lableH = 20;
        _addressLable =  [[UILabel alloc] initWithFrame:CGRectMake(addressLableX, lableY, lableW, lableH)];
        _addressLable.font = SystemFont(14);
        
        CGFloat searchValueLableX = addressLableX+lableW +magin;
        _searchValueLable =  [[UILabel alloc] initWithFrame:CGRectMake(searchValueLableX, lableY, lableW, lableH)];
      _searchValueLable.font = SystemFont(14);
        _searchValueLable.textAlignment =NSTextAlignmentCenter;
        
        CGFloat previousValueLablex = searchValueLableX + lableW + magin;
        _previousValueLable =  [[UILabel alloc] initWithFrame:CGRectMake(previousValueLablex, lableY, lableW, lableH)];
            _previousValueLable.font = SystemFont(14);

        
        [self addSubview:_addressLable];
        [self addSubview:_searchValueLable];
        [self addSubview:_previousValueLable];

        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(10.0f, self.frame.size.height - 1, SCREEN_WIDTH, 1.0f);
        bottomBorder.backgroundColor = LINE_COLOR.CGColor;
        [self.layer addSublayer:bottomBorder];
        
        //        self.backgroundColor = [UIColor clearColor];
                self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)settingData:(SearchResults *)searchResults  indexPath:(NSIndexPath *)indexPath{
    
    [_addressLable setText:[NSString stringWithFormat:@"%@",searchResults.memoryAddress]];
    [_searchValueLable setText:[NSString stringWithFormat:@"%@",searchResults.searchValue]];
    [_previousValueLable setText:[NSString stringWithFormat:@"%@",searchResults.previousValue]];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SearchResultsTableViewCell";
    SearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SearchResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


@end
