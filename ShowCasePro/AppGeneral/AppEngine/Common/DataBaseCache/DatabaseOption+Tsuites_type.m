//
//  DatabaseOption+Tsuites_type.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Tsuites_type.h"
#import "Tsuites_type.h"

@implementation DatabaseOption (Tsuites_type)

- (NSMutableArray *)selectTypeBySuitesID:(NSString *)suitesid
{
    NSString *strSQL = @"select * from tsuites_type where suitesid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[suitesid]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        Tsuites_type *type = [[Tsuites_type alloc] init];
        type.tsuites_typeid = [rs stringForColumn:@"id"];
        type.suitesid = [rs stringForColumn:@"suitesid"];
        type.subtype_name = [rs stringForColumn:@"subtype_name"];
        type.image = [rs stringForColumn:@"image"];
        type.create_time = [rs stringForColumn:@"create_time"];
        type.update_time = [rs stringForColumn:@"update_time"];
        [arr addObject:type];
    }
    return arr;
}

@end
