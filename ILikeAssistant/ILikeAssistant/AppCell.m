//
//  AppCell.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        _iconView = [[UIImageView alloc] init];
        _iconView.frame = CGRectMake(15, 5, 40, 40);
        
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 6.0;
     
        
        CGFloat appNameX =_iconView.frame.origin.x+_iconView.frame.size.width+10;
        _appNameLable = [[UILabel alloc] initWithFrame:CGRectMake(appNameX, 5, SCREEN_WIDTH - appNameX, 40)];
        
        
        [self addSubview:_iconView];
        [self addSubview:_appNameLable];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        CGRect frame = self.frame;
        frame.size.height = 50;
        self.frame = frame;
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(15.0f, self.frame.size.height - 1, SCREEN_WIDTH-30, 1.0f);
        bottomBorder.backgroundColor = [UIColor blackColor ].CGColor;
        [self.layer addSublayer:bottomBorder];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}
-(void)settingData:(AppInfo *)appInfo {
//    _iconView.image  = [UIImage imageNamed:appInfo.icon];
    _iconView.image = appInfo.image;
    [_appNameLable setText:appInfo.appName];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"AppCell";
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerDetailsTableViewCell" owner:nil options:nil] lastObject];
        cell = [[AppCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}



@end
