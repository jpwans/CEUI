//
//  DataType.h
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataType : NSObject
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, assign) NSInteger dataIndex;

+(NSArray *)createDataArrays;
+(NSMutableArray *)initializeDataArrays;
@end
