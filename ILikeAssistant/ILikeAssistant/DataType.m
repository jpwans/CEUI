//
//  DataType.m
//  ILikeAssistant
//
//  Created by MoPellet on 15/8/27.
//  Copyright (c) 2015年 MoPellt. All rights reserved.
//

#import "DataType.h"

@implementation DataType
+(NSArray *)createDataArrays{
    NSArray *dataTypeArray = [NSArray arrayWithObjects:@"Auto",@"Binary",@"Byte",@"2 Bytes",@"4 Bytes" ,@"8 Bytes" ,@"Float" ,@"Double" ,@"Text"  ,nil];
    return dataTypeArray;
}
+(NSMutableArray *)initializeDataArrays
{
    NSArray *arrays = [DataType createDataArrays];
    NSMutableArray *dataArrays ;
    if (!dataArrays) {
        dataArrays = [NSMutableArray new];
        for (int i = 0; i<arrays.count; i++) {
            DataType *dataType = [DataType new];
            dataType .dataString = [arrays objectAtIndex:i];
            dataType.dataIndex = i;
            [dataArrays addObject:dataType];
        }
    }
    return dataArrays;
}
@end
