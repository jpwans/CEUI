//
//  SearchResults.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/26.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataType;
@interface SearchResults : NSObject
@property(nonatomic,strong) NSString *memoryAddress;
@property(nonatomic,strong) NSString *searchValue;
@property (nonatomic, strong) NSString *charType;
@property (nonatomic, strong) NSString *previousValue;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic, strong) DataType *dataType;
@end



