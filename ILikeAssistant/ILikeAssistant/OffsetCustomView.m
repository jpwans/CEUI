//
//  OffsetCustomView.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/29.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "OffsetCustomView.h"

@interface OffsetCustomView ()
@property(nonatomic,strong)NSString *groupId;
@property(nonatomic,assign) int pointOffset;
@property(nonatomic,strong) UITextField *numTextField;
@property(nonatomic,strong) UIButton * subButton;
@property(nonatomic,strong) UIButton * addButton;
@property(nonatomic,strong) UILabel *resultLabel;
@end

@implementation OffsetCustomView
static const NSUInteger kMagin=8;


static NSMutableArray *Offset_instances=nil;
static  NSString *plus = @"+";
static  NSString *equal  = @"=";
static const  int  singleOffset = 4 ;
- (instancetype)initWithFrame:(CGRect)frame :(NSString*)groupId :(NSUInteger)index :(id)observer{
    self = [self init];
    if (self) {
        
        self.tag = index;
        _groupId = groupId;
        self.frame =frame;
        //        self.layer.borderWidth = 1;
        //        self.layer.borderColor = [UIColor blackColor].CGColor;
        [self defaultInit:frame :observer];  // 移动至此
    }
    return  self;
    
}


-(void)defaultInit:(CGRect )frame :(id)observer{
    
    
    
    _subButton = [ToolKit createCustomButton ];
    _addButton = [ToolKit createCustomButton];
    _numTextField = [[UITextField alloc] init];
    _resultLabel = [[UILabel alloc] init];
    
    CGFloat buttonWH =  frame.size.height;
    _subButton.frame = CGRectMake(0, 0, buttonWH, buttonWH);
    [_subButton setTitle:@"<" forState:UIControlStateNormal];
    [_subButton addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_subButton];
    
    _numTextField.frame = CGRectMake(buttonWH+kMagin, 0, 2*buttonWH, buttonWH);
    [_numTextField setText:[NSString stringWithFormat:@"%d",_pointOffset]];
    _numTextField.textAlignment = NSTextAlignmentCenter;
    _numTextField.borderStyle = UITextBorderStyleRoundedRect;
    _numTextField.font = defaultFontSize;
    _numTextField.delegate = observer;
    [_numTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_numTextField];
    
    _addButton.frame = CGRectMake(_numTextField.frame.origin.x +_numTextField.frame.size.width+kMagin , 0, buttonWH, buttonWH);
    [_addButton setTitle:@">" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    CGFloat resultLabelX = _addButton.frame.origin.x +  _addButton.frame.size.width + kMagin;
    CGFloat resultLabelW= frame.size.width - 3*kMagin   -( buttonWH +  _numTextField.frame.size.width + buttonWH);
    _resultLabel.frame = CGRectMake(resultLabelX, 0, resultLabelW, buttonWH);
    [_resultLabel setText:@"12345678+0=12345678"];
    _resultLabel.font = defaultFontSize;
    [self addSubview:_resultLabel];
}

-(void)textFieldChange:(UITextField *)textField {
    
    NSString *result = _resultLabel.text;
    NSRange plusRange = [result rangeOfString:plus];
    NSRange  equalRange = [result rangeOfString:equal];
    
    _resultLabel.text = [result stringByReplacingCharactersInRange:NSMakeRange(plusRange.location+1, equalRange.location - (plusRange.location+1)) withString:textField.text.length?textField.text :@"?"];
    
}
-(void)subAction:(UIButton *) button{
    _pointOffset  -=singleOffset;
    [_numTextField setText:   [ToolKit stringWith:_pointOffset]];
}
-(void)addAction:(UIButton *) button{
    _pointOffset  +=singleOffset;
    [_numTextField setText:   [ToolKit stringWith:_pointOffset]];
}
@end
