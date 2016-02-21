

#import <UIKit/UIKit.h>
#import "DataType.h"
@interface DropDownTableView :UIView <UITableViewDelegate, UITableViewDataSource>
-(void)hideDropDown:(UIButton *)b;
-(id)initWith:(UIButton *)b :(CGFloat )height :(NSArray *)arr;
@end
