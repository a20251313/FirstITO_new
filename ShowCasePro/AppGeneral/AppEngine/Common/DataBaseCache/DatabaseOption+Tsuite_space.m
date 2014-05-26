//
//  DatabaseOption+Tsuite_space.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-12.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Tsuite_space.h"

@implementation DatabaseOption (Tsuite_space)

- (NSMutableArray *)selectSpacesBySuiteID:(NSString *)suiteid
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tsuite_space where suites_id=%@", suiteid];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        Tsuite_space *suiteSpace = [[Tsuite_space alloc] init];
        suiteSpace.tsuite_spaceid = [rs stringForColumn:@"id"];
        suiteSpace.space_name = [rs stringForColumn:@"space_name"];
        suiteSpace.image_ico = [rs stringForColumn:@"image_ico"];
        suiteSpace.suites_id = [rs stringForColumn:@"suites_id"];
        suiteSpace.param1 = [rs stringForColumn:@"param1"];
        suiteSpace.param2 = [rs stringForColumn:@"param2"];
        suiteSpace.update_time = [rs stringForColumn:@"update_time"];
        [arr addObject:suiteSpace];
    }
    return arr;
}

@end
