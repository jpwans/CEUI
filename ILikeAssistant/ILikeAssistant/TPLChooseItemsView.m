//
//  IFChooseItemsView.m
//  MaMaShoppingPro
//
//  Created by 谭鄱仑 on 14-9-18.
//  Copyright (c) 2014年 谭鄱仑. All rights reserved.
//

#import "TPLChooseItemsView.h"
#define dealocInfo NSLog(@"%@ 释放了",[self class])
#import  <objc/runtime.h>
#import "MulitfyManage.h"

@implementation ChooseItem
-(void)dealloc
{
    //    dealocInfo;
}


#pragma mark
#pragma mark           porperyt
#pragma mark
-(void)setChooseColor:(UIColor *)chooseColor
{
    _chooseColor = chooseColor;
    [self refresh];
}

-(void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [self refresh];
}

-(void)setIsChoose:(BOOL)isChoose
{
    _isChoose = isChoose;
    [self refresh];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.textColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        _isChoose = NO;
        
        
        self.layer.cornerRadius = 6;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5;
        
        
        self.textAlignment = NSTextAlignmentCenter;
        
        
        [self refresh];
        
        UITapGestureRecognizer * tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOne:)];
        tapOne.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapOne];
    }
    return self;
}



-(void)tapOne:(UITapGestureRecognizer * )tapOne
{
    
    _isChoose = !_isChoose;
    //    self.layer.backgroundColor = _isChoose ? [UIColor greenColor].CGColor : [UIColor whiteColor].CGColor;
    [self refresh];
    
//        self.layer.borderWidth = _isChoose ? 1:0.5;
    
    typeof(self) __weak weak_self = self;
    self.clicked(weak_self);
    
    NSMutableDictionary * dictionary = [NSMutableDictionary new];
    [dictionary setObject:[NSString stringWithFormat:@"%lu",(unsigned long)weak_self.index] forKey:@"index"];
    [NotificationCenter postNotificationName:Notif_DidSelectedToDataType  object:nil userInfo:dictionary];
}

-(void)refresh
{
    self.layer.borderColor = _isChoose ? _chooseColor.CGColor : _normalColor.CGColor;
    self.textColor = _isChoose ? _chooseColor : _normalColor;
}

@end



@interface TPLChooseItemsView ()
{
    //data
    NSMutableArray * _itemArray;
}

@end

@implementation TPLChooseItemsView
@synthesize itemArray = _itemArray;
-(void)dealloc
{
    //    dealocInfo;
}

#pragma mark
#pragma mark           porperty
#pragma mark
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self refreshView];
}

-(NSArray*)chooseArray
{
    NSMutableArray * chooseArray = [NSMutableArray arrayWithCapacity:0];
    for (int i =0; i<_itemArray.count; i++) {
        ChooseItem * label = [_itemArray objectAtIndex:i];
        label.index = i;
        if (label.isChoose)
        {
            [chooseArray addObject:label];
        }
    }
    
    //    for (ChooseItem * label in _itemArray)
    //    {
    //        if (label.isChoose)
    //        {
    //            [chooseArray addObject:label];
    //        }
    //    }
    return [chooseArray copy];
}

-(NSString*)chooseString
{
    NSMutableArray * chooseTextArray = [NSMutableArray arrayWithCapacity:0];
    for (ChooseItem * label in _itemArray)
    {
        if (label.isChoose)
        {
            [chooseTextArray addObject:label.text];
        }
    }
    
    return [chooseTextArray componentsJoinedByString:@","];
}



-(void)setItemHeight:(CGFloat)itemHeight
{
    _itemHeight = itemHeight;
    [self refreshView];
}

-(void)setItemFont:(UIFont *)itemFont
{
    _itemFont = itemFont;
    for (ChooseItem * label in _itemArray)
    {
        label.font = itemFont;
    }
}

-(void)setItemMixLength:(CGFloat)itemMixLength
{
    _itemMixLength = itemMixLength;
    [self refreshView];
}

-(void)setItemHorizontalMargin:(CGFloat)itemHorizontalMargin
{
    _itemHorizontalMargin = itemHorizontalMargin;
    [self refreshView];
}

-(void)setHorizontalMargin:(CGFloat)horizontalMargin
{
    _horizontalMargin = horizontalMargin;
    [self refreshView];
}

-(void)setVertaicalMargin:(CGFloat)vertaicalMargin
{
    _vertaicalMargin = vertaicalMargin;
    [self refreshView];
}

-(void)setXSpace:(CGFloat)xSpace
{
    _xSpace = xSpace;
    [self refreshView];
}

-(void)setYSpace:(CGFloat)ySpace
{
    _ySpace = ySpace;
    [self refreshView];
}


-(void)setRowColorArray:(NSMutableArray *)rowColorArray
{
    _rowColorArray = rowColorArray;
    [self refreshView];
}


-(void)setIsFitLength:(BOOL)isFitLength
{
    _isFitLength = isFitLength;
    [self refreshView];
}

-(void)setIsNeat:(BOOL)isNeat
{
    _isNeat = isNeat;
    [self refreshView];
}
-(void)setIsMutableChoose:(BOOL)isMutableChoose
{
    _isMutableChoose = isMutableChoose;
    [self refreshView];
}


-(void)setItemChooseColor:(UIColor *)itemChooseColor
{
    _itemChooseColor = itemChooseColor;
    [self refreshView];
}

-(void)setItemNormalColor:(UIColor *)itemNormalColor
{
    _itemNormalColor = itemNormalColor;
    [self refreshView];
}

-(void)setItemTextColor:(UIColor *)itemTextColor
{
    _itemTextColor = itemTextColor;
    [self refreshView];
}



#pragma mark
#pragma mark           init
#pragma mark
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        //init
        _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
        _itemArray = [[NSMutableArray alloc] initWithCapacity:0];
        _rowColorArray = [@[[UIColor whiteColor]] mutableCopy];
        
        _itemHeight = 25;
        _itemWidth = 100;
        _itemMixLength = 70;
        _itemHorizontalMargin = 12;
        _horizontalMargin = 20;
        _vertaicalMargin = 10;
        _xSpace = 10;
        _ySpace = 20;
        
        _itemFont = [UIFont systemFontOfSize:12];
        _itemTextColor = [UIColor grayColor];
        
        _isFitLength = YES;
        _isNeat = YES;
        _isMutableChoose = YES;
        
    }
    return self;
}

#pragma mark
#pragma mark           help
#pragma mark
//点击其中元素
-(void)clickedItemIndex:(NSInteger)index
{
    
    [(ChooseItem*)[self.itemArray objectAtIndex:index] tapOne:nil];
    
    
}

//没有处理标题比比一行宽还要宽的情况
-(void)refreshView
{
    //清空之前的
    while (_itemArray.count > 0)
    {
        [_itemArray.lastObject removeFromSuperview];
        [_itemArray removeLastObject];
    }
    
    
    void (^clickedBlock)(ChooseItem * item) = ^(ChooseItem * item){
        
        if (!_isMutableChoose)
        {
            NSArray * array = self.chooseArray;
            for (int i =0; i<array.count; i++) {
                ChooseItem * item = array[i];
                item.isChoose = NO;
            }
            item.isChoose = YES;
        }
    };
    
    CGFloat rowHeight = _itemHeight;
    CGFloat x = _horizontalMargin;
    CGFloat y = _vertaicalMargin;
    CGFloat rowWidth = self.frame.size.width - _horizontalMargin*2;
    UIFont  * titleFont = _itemFont;
    CGFloat tempWidth = rowWidth;
    NSInteger colorPointer = 0;
    for (int i = 0; i < _titleArray.count; i++)
    {
        //        CGFloat labelWidth = [TPLHelpTool lengthOfString:[_titleArray objectAtIndex:i] withFont:titleFont];
        CGFloat labelWidth = [TPLChooseItemsView lengthOfString:[_titleArray objectAtIndex:i] withFont:titleFont];
        
        //如果小于最短长度，则扩大到最短长度
        labelWidth = labelWidth > _itemMixLength ? labelWidth + _itemHorizontalMargin*2 : _itemMixLength;
        //如果不需要自适应长度
        if (!_isFitLength)
        {
            labelWidth = _itemWidth;
        }
        
        //处理是否能放得下
        if (labelWidth <= tempWidth)//能放下
        {
            ChooseItem * label = [[ChooseItem alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
            label.clicked = clickedBlock;
            label.layer.backgroundColor = [[_rowColorArray objectAtIndex:colorPointer] CGColor];
            label.chooseColor = _itemChooseColor;
            label.normalColor = _itemNormalColor;
            label.textColor = _itemTextColor;
            label.text = [_titleArray objectAtIndex:i];
            label.font = _itemFont;
            [self addSubview:label];
            [_itemArray addObject:label];
            x = x + labelWidth + _xSpace;
            tempWidth = tempWidth - labelWidth - _xSpace;
            
            //如果是最后的元素，也要处理顶边
            if (i == _titleArray.count - 1)
            {
                //处理顶边
                [self dealHorizontalMarginWithTempWidth:tempWidth];
            }
        }
        else//放不下
        {
            //处理顶边
            [self dealHorizontalMarginWithTempWidth:tempWidth];
            
            //换行
            x = _horizontalMargin;
            y = y + rowHeight + _ySpace;
            tempWidth = rowWidth;
            colorPointer++;
            if (colorPointer >= _rowColorArray.count)
            {
                colorPointer = 0;
            }
            
            //新行的Lable
            ChooseItem * label = [[ChooseItem alloc] initWithFrame:CGRectMake(x, y, labelWidth, rowHeight)];
            label.clicked = clickedBlock;
            label.layer.backgroundColor = [[_rowColorArray objectAtIndex:colorPointer] CGColor];
            label.chooseColor = _itemChooseColor;
            label.normalColor = _itemNormalColor;
            label.textColor = _itemTextColor;
            label.font = _itemFont;
            label.text = [_titleArray objectAtIndex:i];
            [self addSubview:label];
            [_itemArray addObject:label];
            x = x + labelWidth + _xSpace;
            tempWidth = tempWidth - labelWidth - _xSpace;
        }
    }
}



-(void)dealHorizontalMarginWithTempWidth:(CGFloat)tempWidth
{
    if (_isNeat)
    {
        //处理此行顶边
        //收集此行的Lable
        NSMutableArray * tempLabelArray = [NSMutableArray arrayWithCapacity:0];
        int rowItemIndex = (int)_itemArray.count - 1;
        UILabel * tempLabel = [_itemArray objectAtIndex:rowItemIndex];
        CGFloat tempY = tempLabel.frame.origin.y;
        while (tempLabel.frame.origin.y == tempY)
        {
            [tempLabelArray addObject:tempLabel];
            rowItemIndex--;
            if (rowItemIndex >= 0)
            {
                tempLabel = [_itemArray objectAtIndex:rowItemIndex];
            }
            else
            {
                break;
            }
        }
        //如果一行大于两个Lable，则需要调整顶边
        if (tempLabelArray.count > 0)
        {
            //处理收集到的Lable的位置
            CGFloat  offsetWidth= (tempWidth + _xSpace)/(tempLabelArray.count - 1);
            for (int i = (int)tempLabelArray.count - 2; i >= 0; i--)
            {
                ChooseItem * label = [tempLabelArray objectAtIndex:i];
                label.frame = (CGRect){{label.frame.origin.x + offsetWidth*(tempLabelArray.count - i - 1),label.frame.origin.y},label.frame.size};
            }
        }
    }
}


#define MORE_WIDTH 0
//获得字符串长度
+(CGFloat)lengthOfString:(NSString*)string withFont:(UIFont*)font
{
    NSString * systemString = [TPLChooseItemsView getSystemVersion];
    
    CGSize size;
    if ([systemString intValue] >= 7)
    {
        size = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    }
    else
    {
        size = [string sizeWithFont:font];
    }
    
    return size.width + MORE_WIDTH;
}

//获得操作系统版本号
+(NSString *)getSystemVersion
{
    return  [[UIDevice currentDevice] systemVersion];
}




@end
