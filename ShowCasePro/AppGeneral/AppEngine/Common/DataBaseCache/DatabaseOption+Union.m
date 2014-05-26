//
//  DatabaseOption+Union.m
//  ShowCasePro
//
//  Created by CY-003 on 13-12-19.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Union.h"
#import "Tproduct.h"
#import "DatabaseOption+condition.h"

@implementation DatabaseOption (Union)

//同类产品 type = 1   // 关联产品 type = 2

- (NSArray *) union_productIDArrayWithProductID:(NSString *)productid  type:(NSString *)type
{
    NSString *sql = [NSString stringWithFormat:@"select union_productid from tproduct_union where type = '%@' and productid = '%@'",type,productid];
    
    NSString *resultString = nil;
    
    //NSLog(@"sql :%@",sql);
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    while ([set next]) {
        resultString = [set stringForColumnIndex:0];
    }
    
    //NSLog(@"resultString :%@",resultString);

    
    NSArray *result = [resultString componentsSeparatedByString:@","];
    
    NSMutableArray *vaildPid = [NSMutableArray array];
    
    for (NSString *pid in result)
    {
        Tproduct *product = [self tProductByProductID:pid];
        
        if (product)
        {
            [vaildPid addObject:pid];
            product = nil;
        }
    }

    if (vaildPid.count)
    {
        return vaildPid;
    }
    
    return nil;
}

@end
