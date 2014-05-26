//
//  DatabaseOption+Ttype_suites_union.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Ttype_suites_union.h"
#import "Ttype_suites_union.h"
#import "DatabaseOption+Suites.h"

@implementation DatabaseOption (Ttype_suites_union)

- (NSMutableArray *)selectByTypeid:(NSString *)typeID
{
    NSString *strSQL = @"select * from ttype_suites_union where typeid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[typeID]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        NSString *suiteid = [rs stringForColumn:@"suitesid"];
        [arr addObject:[self getSuiteBysuiteid:suiteid]];
//        Ttype_suites_union *type = [[Ttype_suites_union alloc] init];
//        type.ttype_suites_unionid = [rs stringForColumn:@"id"];
//        type.ttypeid = [rs stringForColumn:@"typeid"];
//        type.suitesid = [rs stringForColumn:@"suitesid"];
//        type.create_time = [rs stringForColumn:@"create_time"];
//        type.update_time = [rs stringForColumn:@"update_time"];
//        [arr addObject:type];
    }
    return arr;
}

@end
