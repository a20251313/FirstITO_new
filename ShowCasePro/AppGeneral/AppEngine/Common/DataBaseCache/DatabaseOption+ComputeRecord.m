//
//  DatabaseOption+ComputeRecord.m
//  ShowCasePro
//
//  Created by Mac on 14-3-17.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+ComputeRecord.h"

@implementation DatabaseOption (ComputeRecord)

-(void)addNewRecord:(NSString *)newRecord
{
    if (!newRecord || !newRecord.length)
    {
        NSLog(@"DatabaseOption+ComputeRecord error: 新记录为空.");
        return;
    }
    
    NSString *sql = [NSString stringWithFormat:@"insert into tcompute_record (recordstring) values ('%@')",newRecord];
       
    if (![self.fmdb executeUpdate:sql])
    {
        NSLog(@"DatabaseOption+ComputeRecord error: 新记录插入失败.");
    }
}

-(NSMutableArray *)allRecord
{
    NSMutableArray *setArray = [NSMutableArray array];
    
    NSString *sql = @"select recordstring from tcompute_record";

    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    while ([set next])
    {
        NSString *str = [set stringForColumnIndex:0];
        [setArray addObject:str];
    }
    
    if (setArray.count == 0)
    {
        return nil;
    }
    
    return setArray;
}

-(void)cleanAllRecord
{
    NSString *sql = @"delete from tcompute_record";

    if (![self.fmdb executeUpdate:sql])
    {
        NSLog(@"DatabaseOption+ComputeRecord error: 记录清除失败.");
    }
}

@end
