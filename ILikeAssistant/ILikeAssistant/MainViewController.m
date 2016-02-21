//
//  MainViewController.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/24.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "MainViewController.h"
#import "AppListTableViewController.h"
#import "TPLChooseItemsView.h"
#import "AppInfo.h"
#import "SearchResults.h"
#import "SelectionTableView.h"
#import "SearchResultsTableView.h"
#import "ModifyViewController.h"
#import "PrivateApiHeader.h"

#import "MulitfyManage.h"
@interface MainViewController ()
@property(nonatomic,strong)   UIButton *addAppButton ;
@property(nonatomic,strong)    UIButton *pauseButton ;
@property(nonatomic,assign) BOOL isPlay;
@property(nonatomic,assign) NSInteger speedCount;
@property(nonatomic,strong) NSMutableArray *resultArrays;

@property(nonatomic ,strong) SelectionTableView *selectionTableView;
@property(nonatomic ,strong) SearchResultsTableView *searchResultsTableView;
@property(nonatomic,strong) NSMutableArray *searchResultsArrays;

@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UIScrollView *searchResultsScrollView;
@property(nonatomic,assign) CGRect scrollViewFrame ;
@property(nonatomic,assign) CGSize scrollViewContentSize;
@property(nonatomic,assign) CGRect selectionTableViewFrame;

@property (nonatomic, strong)  UIView *secondView;
@property(nonatomic,assign) CGRect secondViewFrame ;


@property(nonatomic,strong)  TPLChooseItemsView * chooseItemsView;
@property(nonatomic,assign) BOOL isChooseItemsCreate;
@property(nonatomic,assign) int ChooseItemsCount;

@end

@implementation MainViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO ; //禁用右滑手势
    self.view.backgroundColor =[UIColor colorWithRed:239/255 green:222/225 blue:205/225 alpha:0.3];
    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.7)];
    showView.backgroundColor = [UIColor colorWithRed:172/255 green:229/225 blue:238/225 alpha:0.3];
    
    [self.view addSubview:showView];
    
    
    _addAppButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAppButton .adjustsImageWhenHighlighted = NO;
    _addAppButton.frame = CGRectMake(0, 0, 50, 50);
    _addAppButton.center = showView.center;
    
    [_addAppButton setImage:[UIImage imageNamed:@"square_add"] forState:UIControlStateNormal];
    [_addAppButton addTarget:self action:@selector(addAppAction:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:_addAppButton];
    _addAppButton.layer.masksToBounds = YES;
    _addAppButton.layer.cornerRadius = 6.0;
    
    
    
    CGFloat textFieldW = SCREEN_WIDTH-30 -  (SCREEN_WIDTH*0.7+10) ;
    UITextField * textField = [[UITextField alloc ]initWithFrame:CGRectMake(SCREEN_WIDTH*0.7+10, 20, textFieldW, 30)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font  = [UIFont systemFontOfSize:(12)];
    textField.placeholder  = @"输入搜索的数值...";
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, textField.frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftView;
    [self.view addSubview:textField];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton .adjustsImageWhenHighlighted = NO;
    searchButton .frame = CGRectMake(SCREEN_WIDTH-30,textField.frame.origin.y , 30, 30);
    [searchButton setImage:[UIImage imageNamed:@"search@3x"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
    
    //    CGFloat toolButtonHeight = 50;
    CGFloat toolWidth =SCREEN_WIDTH*0.3;
    CGFloat toolHeight  = (toolWidth -40)/3;
    
    UIView *toolsView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.7,textField.frame.origin.y+textField.frame.size.height+8 ,toolWidth, toolHeight)];
    //        toolsView.layer.borderColor = [UIColor redColor].CGColor;
    //        toolsView.layer.borderWidth = 1;
    [self.view addSubview:toolsView];
    
    
    CGFloat toolButtonWidth =toolHeight;
    
    UIButton *slowDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    slowDownButton.frame = CGRectMake(10, 0, toolButtonWidth, toolButtonWidth);
    [slowDownButton setImage:[UIImage imageNamed:@"circle_rewind"] forState:UIControlStateNormal ];
    [slowDownButton addTarget:self action:@selector(slowDown:) forControlEvents:UIControlEventTouchUpInside];
    [toolsView addSubview:slowDownButton];
    
    
    
    
    
    CGFloat tableViewY =toolsView.frame.origin.y+toolsView.frame.size.height+8 ;
    CGFloat tableViewH = SCREEN_HEIGHT -tableViewY;
    CGFloat contentW = 242;
    
    self.searchResultsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.7,tableViewY, toolWidth,tableViewH )];
    self.searchResultsScrollView.showsHorizontalScrollIndicator = NO;
    self.searchResultsScrollView.contentSize = CGSizeMake(contentW, tableViewH);
    self.searchResultsScrollView.backgroundColor =BACKGROUND_COLOR;
    [self.view addSubview:self.searchResultsScrollView];
    
    _searchResultsTableView = [[SearchResultsTableView alloc] initWithFrame:CGRectMake(0, 0, contentW, tableViewH)];
    _searchResultsTableView.backgroundColor = [UIColor whiteColor];
    [self.searchResultsScrollView addSubview:_searchResultsTableView];
    //    _searchResultsScrollView.bounces = NO;
    _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pauseButton.frame = CGRectMake(toolButtonWidth+2*10, 0, toolButtonWidth, toolButtonWidth);
    [_pauseButton setImage:[UIImage imageNamed:@"circle_play"] forState:UIControlStateNormal ];
    [_pauseButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [toolsView addSubview:_pauseButton];
    _isPlay = NO;
    _speedCount = 0;
    
    UIButton *accelerateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    accelerateButton.frame = CGRectMake(toolButtonWidth*2+3*10, 0, toolButtonWidth, toolButtonWidth);
    [accelerateButton setImage:[UIImage imageNamed:@"circle_fast_forward"] forState:UIControlStateNormal ];
    [accelerateButton addTarget:self action:@selector(accelerate:) forControlEvents:UIControlEventTouchUpInside];
    [toolsView addSubview:accelerateButton];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchDownToKeyboard:)];
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    
    
    [NotificationCenter addObserver:self selector:@selector(callbackFromAppList:) name:Notif_SendValue object:nil];
    
    CGFloat tableY = SCREEN_HEIGHT * 0.7;
    CGFloat tableW =SCREEN_WIDTH * 0.7 ;
    CGFloat tableH =SCREEN_WIDTH * 0.3;
    CGFloat viewWidth = tableW;
    CGFloat viewHeight =tableH;
    _scrollViewFrame =CGRectMake(0,tableY, viewWidth,viewHeight );
    self.scrollView = [[UIScrollView alloc] initWithFrame:_scrollViewFrame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    _scrollViewContentSize =CGSizeMake(viewWidth * 2, viewHeight);
    self.scrollView.contentSize = _scrollViewContentSize;
    //    self.scrollView.delegate = self;
    //    [self.scrollView scrollRectToVisible:CGRectMake(viewWidth, 0, viewWidth, tableH) animated:YES];
    self.scrollView.backgroundColor =BACKGROUND_COLOR;
    [self.view addSubview:self.scrollView];
    
    
    _secondViewFrame  =CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    _secondView =[[UIView alloc ] initWithFrame:_secondViewFrame];
    _secondView.backgroundColor = [UIColor yellowColor];
    
    [self.scrollView addSubview:_secondView];
    
    _selectionTableViewFrame =CGRectMake(0, 0, viewWidth, viewHeight);
    _selectionTableView = [[SelectionTableView alloc] initWithFrame:_selectionTableViewFrame];
    [self.scrollView addSubview:_selectionTableView];
    _selectionTableView .backgroundColor =[UIColor whiteColor];
    
    
    [NotificationCenter addObserver:self selector:@selector(didSelected:) name:Notif_DidSelected object:nil];
    [NotificationCenter addObserver:self selector:@selector(didSelectedToAlert:) name:Notif_DidSelectedToAlert object:nil];
    [NotificationCenter addObserver:self selector:@selector(confirm:) name:Notif_Confirm object:nil];
    [NotificationCenter addObserver:self selector:@selector(didSelectedToDataType:) name:Notif_DidSelectedToDataType object:nil];
    _ChooseItemsCount = 0;
    
    UISwipeGestureRecognizer *recognizer;
    
    
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self scrollView] addGestureRecognizer:recognizer];
    
    
    
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self scrollView] addGestureRecognizer:recognizer];
    recognizer.cancelsTouchesInView = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UIButton *rotatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rotatingButton.frame = CGRectMake(SCREEN_WIDTH*0.7, 0, 20, 20);
    rotatingButton.adjustsImageWhenHighlighted = NO;
    [rotatingButton setImage:[UIImage imageNamed:@"rotating"] forState:UIControlStateNormal];
    [rotatingButton addTarget:self action:@selector(rotationingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotatingButton];
}




/**
 *手势
 */
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        //向下还原
        [UIView animateWithDuration:1.0 animations:^{
            self.scrollView .frame =_scrollViewFrame;
            self.scrollView.alpha = 1;
            self.scrollView.contentSize = _scrollViewContentSize;
            _selectionTableView.frame = _selectionTableViewFrame;
            _secondView.frame = _secondViewFrame;
        } completion:^(BOOL finished) {
            [MulitfyManage mulitfy_show];
        }];
    }
    else if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        //向上放大
        [MulitfyManage mulitfy_hide];
        [UIView animateWithDuration:1.0 animations:^{
            self.scrollView .frame = self.view.bounds;
            self.scrollView.alpha = 0.6;
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
            _selectionTableView.frame = self.view.bounds;
            _secondView .frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        
    }
    
}




#pragma mark NSNotification
-(void)confirm:(NSNotification *)note{
    [_selectionTableView reloadData];
}
-(void)didSelected:(NSNotification *)note{
    
    //    _selectionTableView.resultArrays =  ShareAppDelegate.globalArrays;
    [_selectionTableView reloadData];
}
-(void)keyboardWillShow:(NSNotification *)note{
    NSLog(@"----------App show--------------");
    [MulitfyManage mulitfy_hide];
}
-(void)keyboardWillHide:(NSNotification *)note{
    NSLog(@"----------App hide--------------");
    [MulitfyManage mulitfy_show];
}

-(void)didSelectedToAlert:(NSNotification *)note{
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary  *dictionary = [note userInfo];
        
        [MulitfyManage mulitfy_hide];
        ModifyViewController *  modifyViewController = [[ModifyViewController alloc] init];
        modifyViewController.dictionary = dictionary;
        [self presentViewController:modifyViewController animated:YES completion:nil];
        
    });
    
}
/**
 *旋转角度
 */
-(void)rotationingView:(UIButton*)btn{
    NSLog(@"旋转");
    [MulitfyManage mulitfy_hide];
    double height = SCREEN_WIDTH *2 *0.7;
    double width = SCREEN_HEIGHT *2 *0.7;
    
    if (ShareAppDelegate.rotation==0) {
        ShareAppDelegate.rotation=180;
    }else{
        ShareAppDelegate.rotation=0;
    }
    double x = (SCREEN_HEIGHT*2-width)/2;
    double y = -(SCREEN_WIDTH*2 - height)/2;
    
    [MulitfyManage mulitfy_set:ShareAppDelegate.appid :width :height :ShareAppDelegate.rotation :x :y];
    [MulitfyManage mulitfy_show];
}


-(void)callbackFromAppList:(NSNotification *)note{
    AppInfo *appInfo = [[note userInfo] objectForKey:@"AppInfo"];
    UIImage *image = appInfo.image;
    [_addAppButton setImage:image forState:UIControlStateNormal];
    
    //   mulitfy_set:(NSString *)appID :(double)width :(double)height :(double)rotation :(double)x :(double)y
    double height = SCREEN_WIDTH *2 *0.7;
    double width = SCREEN_HEIGHT *2 *0.7;
    ShareAppDelegate.rotation = 0;
    double x = (SCREEN_HEIGHT*2-width)/2;
    double y = -(SCREEN_WIDTH*2 - height)/2;
    NSLog(@"%f %f %f %f %f",height,width,ShareAppDelegate.rotation,x,y);
    NSLog(@"appid:%@",appInfo.buildId);
    ShareAppDelegate.appid = appInfo.buildId;
    [MulitfyManage mulitfy_set:ShareAppDelegate.appid :width :height :ShareAppDelegate.rotation :x :y];
    [MulitfyManage mulitfy_show];
}

-(void)closeApp:(NSString *)identifier {
 
    if (!identifier)
        goto err;
    
    int pid = 0;
    SBSProcessIDForDisplayIdentifier(identifier, &pid);
    if (pid != 0) {
        NSString* cmd = [NSString stringWithFormat:@"kill -9 %d",pid];
        system([cmd UTF8String]);
    }
    
    err:
    NSLog(@"closeApp 参数不是一个有效的Identifier");
}


- (void)touchDownToKeyboard:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(void)didSelectedToDataType:(NSNotification *)note{
    int  index = [[[note userInfo] objectForKey:@"index"] intValue];
    NSLog(@"%d",index);
    _ChooseItemsCount++;
    if(_ChooseItemsCount==1){
        //        NSLog(@"第一次");
        return;
    }
    ShareAppDelegate.defaultIndex = index;
    
    if (_isChooseItemsCreate) {
        [_chooseItemsView removeFromSuperview];
        [MulitfyManage mulitfy_show];
        _isChooseItemsCreate = !_isChooseItemsCreate;
        //        [MBProgressHUD showMessage:nil];
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getResultArrays];
        //            [MBProgressHUD hideHUD];
        //        });
    }
    
}



#pragma mark Actions
-(void)addAppAction:(UIButton *)button {
    AppListTableViewController * appVC = [[AppListTableViewController alloc] init];
    
    [self.navigationController pushViewController:appVC animated:YES];
}

-(void)searchAction:(UIButton *)button {
    
    if (_isChooseItemsCreate) {
        [_chooseItemsView removeFromSuperview];
        [MulitfyManage mulitfy_show];
    }
    else{
        [MulitfyManage mulitfy_hide];
        [self addChooseItemsView];
        
    }
    _isChooseItemsCreate = !_isChooseItemsCreate;
    
}
//添加选择元素视图背景
-(void)addChooseItemsView{
    _chooseItemsView = [[TPLChooseItemsView alloc] initWithFrame:CGRectMake(0, 0, 100*3+10*4, 4*8+25*3)];
    _chooseItemsView.backgroundColor = RGBCOLOR(253, 217, 181);
    [self.view addSubview:_chooseItemsView];
    _chooseItemsView.alpha = 0.9;
    _chooseItemsView.center =  self.view.center;
    _chooseItemsView.titleArray = ShareAppDelegate.globalDataTypeArrays;
    _chooseItemsView.itemFont = [UIFont systemFontOfSize:14];
    _chooseItemsView.xSpace = 8;
    _chooseItemsView.ySpace = 8;
    _chooseItemsView.isNeat = NO;
    _chooseItemsView.isFitLength = NO;
    _chooseItemsView.isMutableChoose = NO;
    _chooseItemsView.itemChooseColor =  [UIColor redColor];
    _chooseItemsView.itemNormalColor = [UIColor grayColor];
    _chooseItemsView.horizontalMargin = 10;
    [_chooseItemsView clickedItemIndex:ShareAppDelegate.defaultIndex];
    
}


-(void)getResultArrays{
    SearchResults *searchResults = [SearchResults new];
    searchResults.memoryAddress = @"1D7E6710";
    searchResults.searchValue = @"00000012";
    searchResults.charType = @"W";
    searchResults.describe=@"血量";
    searchResults.previousValue = @"00000018";
    searchResults.dataType = [DataType new];
    searchResults.dataType.dataIndex= 2;
    
    SearchResults *searchResults2 = [SearchResults new];
    searchResults2.memoryAddress = @"1D7EB6C8";
    searchResults2.searchValue = @"00000015";
    searchResults2.charType = @"DW";
    searchResults2.describe=@"蓝量";
    searchResults2.previousValue = @"00000020";
    searchResults2.dataType = [DataType new];
    searchResults2.dataType.dataIndex =3;
    
    _resultArrays =[NSMutableArray new];
    [_resultArrays addObject:searchResults];
    [_resultArrays addObject:searchResults2];
    
    _searchResultsTableView.resultArrays = _resultArrays;
    [_searchResultsTableView reloadData];
    
    
    //    _selectionTableView.resultArrays = _resultArrays;
    //    [_selectionTableView reloadData];
}


-(void)slowDown:(UIButton *)button
{
    _speedCount  -=1;
    [self.view makeToast:[NSString stringWithFormat:@"当前速度x%ld",(long)_speedCount] duration:1.5f position:@"center"];
}

-(void)play:(UIButton *)button
{
    UIImage *image  = [UIImage imageNamed:_isPlay?@"circle_play":@"circle_pause"];
    [_pauseButton setImage:image forState:UIControlStateNormal];
    [self.view makeToast: _isPlay?@"恢复":@"暂停" duration:1.5f position:@"center"];
    _isPlay = !_isPlay;
    
}
-(void)accelerate:(UIButton *)button{
    _speedCount  +=1;
    [self.view makeToast:[NSString stringWithFormat:@"当前速度x%ld",(long)_speedCount] duration:1.5f position:@"center"];
}




@end
