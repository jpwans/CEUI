//
//  ModifyViewController.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/28.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownTableView.h"
#import "DataType.h"
@interface ModifyViewController : UIViewController
@property (nonatomic, strong) NSDictionary *dictionary;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic)  IBOutlet  UIButton *btnSelect;
@property (strong, nonatomic) DropDownTableView *dropDownTableView;
@property (nonatomic, strong) NSMutableArray *dataArrays;
- (IBAction)selectClicked:(UIButton *)button;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *pointerButton;
- (IBAction)pointerAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *describeTextField;

@end
