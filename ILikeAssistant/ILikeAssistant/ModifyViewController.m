//
//  ModifyViewController.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/28.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "ModifyViewController.h"
#import "OffsetCustomView.h"
#import "SearchResults.h"
#import "MulitfyManage.h"
@interface ModifyViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,assign) CGRect scrollFrame;
@property(nonatomic,assign) BOOL isChecked;
@property(nonatomic,strong) UIView  *pointerContentView;
@property(nonatomic,assign) int pointOffset;
@property(nonatomic,strong) UITextField *numTextField;
@property (nonatomic,strong) UIButton *addOffsetButton;
@property(nonatomic,strong)UIButton *removeOffsetButton;
@property(nonatomic,assign) CGRect offsetCustomViewFrame;
@property(nonatomic,strong)  UITextField *pointerAddressTextField;
@property(nonatomic,strong)   UILabel * pointerAdderssLabel;
/**
 *  SelectionTableView 点击
 */
@property(nonatomic,strong) SearchResults * searchResults;
@property(nonatomic,strong) NSIndexPath *indexPath ;


@property(nonatomic,assign)NSInteger dropDownIndex;
@end

@implementation ModifyViewController
static  NSUInteger offsetViewCount=0; //修改指针偏移个数
static  CGFloat  higherY = 0;//
- (void)viewDidLoad {
    [super viewDidLoad];
    _dropDownIndex   = -1;
    
    [self setNavigationbar];
    _pointOffset =0;
    _btnSelect .backgroundColor = [UIColor whiteColor];
    _btnSelect.layer.borderWidth = 1;
    _btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnSelect.layer.cornerRadius = 6;
    _scrollFrame = _scrollView.frame;
    [_btnSelect setTitleEdgeInsets:UIEdgeInsetsMake(0, 13.0, 0.0, 0.0)];
    
    _describeTextField .delegate =self;
    [NotificationCenter addObserver:self selector:@selector(emptyForDropDown:) name:Notif_EmptyToDropDown object:nil];
    
    _scrollView.  alwaysBounceVertical =YES;
    _scrollView.backgroundColor = BACKGROUND_COLOR;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchDownToView:)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
    [self setTextFieldDelegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _indexPath = [_dictionary objectForKey:@"NSIndexPath"];
    _searchResults =ShareAppDelegate.globalArrays[_indexPath.row];
    _addressTextField.text = _searchResults.memoryAddress;
    
    _describeTextField.text = _searchResults.describe;
    [_btnSelect setTitle:    [ShareAppDelegate.globalDataTypeArrays objectAtIndex:_searchResults.dataType.dataIndex] forState:UIControlStateNormal];
}

-(void)emptyForDropDown:(NSNotification *)note{
    NSIndexPath *iPath = [[note userInfo] objectForKey:@"NSIndexPath"];
    _dropDownIndex =iPath.row;
    _dropDownTableView = nil;
}

-(void)setTextFieldDelegate{
    for (UIView *view in self.scrollView.subviews)  {
        if ([NSStringFromClass([view class]) isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.delegate =self;
        }
    }
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"%@",string);
//
//    NSLog(@"%@",    textField.superview);
//    return YES;
//}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat textFieldBottomY ;
    if ([NSStringFromClass([textField.superview class]) isEqualToString:@"UIScrollView"]) {
        textFieldBottomY = textField.frame.origin.y + textField.frame.size.height;
    }
    else{
        textFieldBottomY = textField.frame.origin.y + textField.frame.size.height +_pointerButton.frame.origin.y +_pointerButton.frame.size.height +8;
    }
    
    [_scrollView setContentOffset:CGPointMake(0,textFieldBottomY) animated:YES];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //    _scrollView.contentSize   = _scrollFrame.size;
    return YES;
    
}



- (void)setNavigationbar
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 44)];
    //创建UINavigationItem
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"更改地址"];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    //设置barbutton
    navigationBarTitle.leftBarButtonItem = leftItem;
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    [self.view addSubview: navigationBar];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];
    navigationBarTitle.rightBarButtonItem = rightItem;
    
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    //    NSLog(@"%@", NSStringFromClass([touch.view class]));
    //
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        return NO;
    }
    return  YES;
}
- (void)touchDownToView:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [_dropDownTableView hideDropDown:_btnSelect];
    _dropDownTableView = nil;
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    
    //    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _scrollView.contentSize =_scrollFrame.size;
    
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    //        NSLog(@"%@",notification);
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSLog(@"%@",[notification userInfo]);
    NSLog(@"keyboardFrame.size.height:%f",keyboardFrame.size.height);
    CGFloat contentH = keyboardFrame.size.height + _scrollFrame.size.height;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentH);
    
}

#pragma mark navigationButtonAction

-(void)backAction :(UIBarButtonItem *)item {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [MulitfyManage mulitfy_show];
}

-(void)saveAction :(UIBarButtonItem *)item {
    _searchResults.memoryAddress = _addressTextField.text;
    _searchResults.describe = _describeTextField.text;
    _searchResults.dataType.dataIndex = _dropDownIndex>=0?_dropDownIndex:_searchResults.dataType.dataIndex;
    [ShareAppDelegate.globalArrays replaceObjectAtIndex:_indexPath.row withObject:_searchResults];
    [self.view makeToast:@"Save successful " duration:2 position:@"center"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [MulitfyManage mulitfy_show];
    });
    [NotificationCenter postNotificationName:Notif_Confirm object:nil];
}



- (IBAction)selectClicked:(UIButton *)button {
    [self.view endEditing:YES];
    
    NSArray *dataArrays = [DataType createDataArrays];
    
    if (!_dataArrays) {
        _dataArrays = [NSMutableArray new];
        for (int i = 0; i<dataArrays.count; i++) {
            
            DataType *dataType = [DataType new];
            dataType .dataString = [dataArrays objectAtIndex:i];
            dataType.dataIndex = i;
            [_dataArrays addObject:dataType];
        }
    }
    
    if(_dropDownTableView == nil) {
        CGFloat  height =_scrollView .frame.size.height-  (_btnSelect.frame.origin.y+ _btnSelect.frame.size.height)-20;
        _dropDownTableView = [[DropDownTableView alloc] initWith:button :height :_dataArrays ];
    }
    else {
        [_dropDownTableView hideDropDown:button];
        _dropDownTableView = nil;
    }
}
/**
 *是否选择指针
 */
- (IBAction)pointerAction:(UIButton *)sender {
    _isChecked = !_isChecked;
    UIImage *image  = [UIImage imageNamed:_isChecked?@"checked":@"unchecked"];
    [_pointerButton setImage:image forState:UIControlStateNormal];
    
    UIColor *bgColor = _isChecked?[UIColor grayColor]:[UIColor whiteColor];
    
    _addressTextField.background =[ToolKit createImageWithColor:bgColor];
    
    if (_isChecked) {
        _addressTextField.enabled = NO;
        [self createPointerControls];
    }
    else{
        _addressTextField.enabled = YES;
        [_pointerContentView removeFromSuperview];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}


-(void)createPointerControls{
    
    offsetViewCount =1;
    _pointerContentView = [UIView new];
    _offsetCustomViewFrame = CGRectMake( 0, 0, 360, 30);
    
    _pointerAddressTextField = [[UITextField alloc] init];
    _pointerAdderssLabel = [[UILabel alloc] init];
    OffsetCustomView *offsetCustomView = [[OffsetCustomView alloc]  initWithFrame:_offsetCustomViewFrame :@"group" :offsetViewCount:self ];
    [_pointerContentView addSubview:offsetCustomView];
    
    _addOffsetButton  =  [ToolKit createCustomButton ];
    _removeOffsetButton  = [ToolKit createCustomButton ];
    [self refreshConstantView:0];
    
    [_scrollView addSubview:_pointerContentView];
    
}

-(void) refreshConstantView:(CGFloat )higherY{
    
    CGFloat pointerContentViewX  = _pointerButton.frame.origin.x;
    CGFloat pointerContentViewY = _pointerButton.frame.origin.y +_pointerButton.frame.size.height +KMargin;
    CGFloat pointerWH   = _offsetCustomViewFrame.size.height ;
    NSLog(@"pointerWH:%f",pointerWH);
    CGFloat pointerAddressTextFieldY;
    
    pointerAddressTextFieldY = (pointerWH + KMargin) +higherY;
    NSLog(@"pointerAddressTextFieldY:%f",pointerAddressTextFieldY);
    CGFloat pointerAddressTextFieldW = pointerWH *2*2 +KMargin*2 ;
    _pointerAddressTextField.frame = CGRectMake(0, pointerAddressTextFieldY, pointerAddressTextFieldW , pointerWH);
    _pointerAddressTextField.borderStyle = UITextBorderStyleRoundedRect;
    _pointerAddressTextField .delegate =self;
    [_pointerContentView addSubview:_pointerAddressTextField];
    
    
    CGFloat pointerAdderssLabelX = pointerAddressTextFieldW +KMargin;
    CGFloat pointerAdderssLabelW= _offsetCustomViewFrame.size.width - 3*KMargin   -( pointerWH +  pointerWH*2+ pointerWH);
    _pointerAdderssLabel .frame = CGRectMake(pointerAdderssLabelX, pointerAddressTextFieldY, pointerAdderssLabelW, pointerWH);
    _pointerAdderssLabel.font = defaultFontSize;
    [_pointerAdderssLabel setText:@"->000000"];
    [_pointerContentView addSubview:_pointerAdderssLabel];
    
    
    
    CGFloat  addOffsetButtonY  = pointerAddressTextFieldY +pointerWH + KMargin ;
    CGFloat addOffsetButtonW = (_offsetCustomViewFrame.size.width-40)/2 ;
    
    _addOffsetButton.frame = CGRectMake(0, addOffsetButtonY, addOffsetButtonW, pointerWH);
    [_addOffsetButton setTitle:@"Add Offset" forState:UIControlStateNormal];
    _addOffsetButton.titleLabel.font = defaultFontSize;
    [_addOffsetButton addTarget:self action:@selector(addOffsetAction:) forControlEvents:UIControlEventTouchUpInside];
    [_pointerContentView addSubview:_addOffsetButton];

    CGFloat removeOffsetButtonX = addOffsetButtonW +KMargin ;
    
    _removeOffsetButton.frame = CGRectMake(removeOffsetButtonX, addOffsetButtonY, addOffsetButtonW, pointerWH);
    [_removeOffsetButton setTitle:@"Remove Offset" forState:UIControlStateNormal];
    _removeOffsetButton.titleLabel.font = defaultFontSize;
    [_removeOffsetButton addTarget:self action:@selector(removeOffsetAction:) forControlEvents:UIControlEventTouchUpInside];
    [_pointerContentView addSubview:_removeOffsetButton];
    
    CGFloat _pointerContentViewH = _removeOffsetButton.frame.origin.y+_removeOffsetButton.frame.size.height;
    _pointerContentView.frame = CGRectMake(pointerContentViewX, pointerContentViewY, _offsetCustomViewFrame.size.width,  _pointerContentViewH );
    _pointerContentView.layer.borderWidth = 1;
    _pointerContentView.layer.borderColor = [UIColor blackColor].CGColor;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, pointerContentViewY +_pointerContentView.frame.size.height );
//    _scrollFrame.size.height=  _scrollFrame.size.height + pointerContentViewY;
    _scrollFrame = CGRectMake(_scrollFrame.origin.x, _scrollFrame.origin.y, SCREEN_WIDTH, pointerContentViewY +_pointerContentView.frame.size.height +20);
    NSLog(@"---------%f",pointerContentViewY +_pointerContentView.frame.size.height);
    if (_pointerContentView) {
        [UIView animateWithDuration:2 animations:^{
            [_scrollView setContentOffset:CGPointMake(0, 20+pointerContentViewY +_pointerContentView.frame.size.height -_scrollView.frame.size.height) animated:YES];
        }];
    }
}
#pragma mark ButtonActions

-(void)addOffsetAction:(UIButton *) button{
    //添加
    if (offsetViewCount>8) {
        [self.view makeToast:@"超出最大限制！" duration:1.5f position:@"center"];
        return;
    }
    offsetViewCount  ++;
    
    _offsetCustomViewFrame.origin.y =_offsetCustomViewFrame.origin.y +_offsetCustomViewFrame.size.height +KMargin;
    OffsetCustomView *offsetCustomView = [[OffsetCustomView alloc]  initWithFrame:_offsetCustomViewFrame :@"group" :offsetViewCount:self ];
    higherY  = (offsetViewCount-1)*(KMargin + _offsetCustomViewFrame.size.height);
    [self refreshConstantView:higherY];
    
    [_pointerContentView addSubview:offsetCustomView];
    
}
-(void)removeOffsetAction:(UIButton *) button{
    //   移动
    for (UIView *view in _pointerContentView.subviews)  {
        if ([NSStringFromClass([view class]) isEqualToString:@"OffsetCustomView"] &&  view.tag == offsetViewCount) {
            [view removeFromSuperview];
            higherY = higherY -(KMargin + _offsetCustomViewFrame.size.height);
            
            [self refreshConstantView:higherY];
            _offsetCustomViewFrame.origin.y =   _offsetCustomViewFrame.origin.y -(_offsetCustomViewFrame.size.height +KMargin);
            offsetViewCount  --;
            NSLog(@"%lu",(unsigned long)offsetViewCount);
            break;
        }
    }
    
    if (offsetViewCount<=0) {
        _isChecked = YES;
        [self pointerAction:nil];
    }
    
}

@end
