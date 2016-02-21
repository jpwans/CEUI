//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "DropDownTableView.h"
#import "QuartzCore/QuartzCore.h"

@interface DropDownTableView ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation DropDownTableView
@synthesize btnSender;
@synthesize list;
@synthesize table;

-(id)initWith:(UIButton *)b :(CGFloat )height :(NSArray *)arr{
    self = [super init];
    if (self) {
        btnSender = b;
        self.table = (UITableView *)[super init];
        CGRect btn = b.frame;
        self.list = [NSArray arrayWithArray:arr];
        
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 6;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, height);
            table.frame = CGRectMake(0, 0, btn.size.width, height);
        }];
        [b.superview addSubview:self];        
        [self addSubview:table];

    }
    return  self;
}




-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        table.frame = CGRectMake(0, 0, btn.size.width, 0);
    }];
    
   
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    

    DataType *dataType = [list objectAtIndex:indexPath.row];
    cell.textLabel.text =dataType.dataString;
    cell.textLabel.textColor = [UIColor blackColor];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(10.0f, 24, btnSender.frame.size.width-20, 1.0f);
    bottomBorder.backgroundColor = LINE_COLOR.CGColor;
    [cell.layer addSublayer:bottomBorder];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DataType *dataType = [list objectAtIndex:indexPath.row];
    [btnSender setTitle:dataType.dataString forState:UIControlStateNormal];
    [self hideDropDown:btnSender];
    NSMutableDictionary * dictionary = [NSMutableDictionary new];
    [dictionary setObject:indexPath forKey:@"NSIndexPath"];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notif_EmptyToDropDown object:nil userInfo:dictionary];
}



@end
