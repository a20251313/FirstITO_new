//
//  DatabaseOption+Tbrand_heritage.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-15.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Tbrand_heritage.h"
#import "Tbrand_heritage.h"

@implementation DatabaseOption (Tbrand_heritage)

- (NSMutableArray *)selectAllHeritage
{
    NSString *strSQL = @"select * from tbrand_heritage";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        Tbrand_heritage *heritage = [[Tbrand_heritage alloc] init];
        heritage.tbrand_heritageid = [rs stringForColumn:@"id"];
        heritage.image = [rs stringForColumn:@"image"];
        heritage.ico = [rs stringForColumn:@"ico"];
        heritage.year = [rs stringForColumn:@"year"];
        heritage.param1 = [rs stringForColumn:@"param1"];
        heritage.param2 = [rs stringForColumn:@"param2"];
        heritage.update_time = [rs stringForColumn:@"update_time"];
        [arr addObject:heritage];
    }
    [rs close];
    return arr;
}

@end
