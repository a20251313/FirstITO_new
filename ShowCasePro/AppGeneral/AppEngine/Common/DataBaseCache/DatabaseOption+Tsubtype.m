//
//  DatabaseOption+Tsubtype.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-9.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Tsubtype.h"
#import "Tsubtype.h"

@implementation DatabaseOption (Tsubtype)

- (NSMutableArray *)getSubtypesByTypeID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tsubtype where typeid=%@", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        Tsubtype *subtype = [[Tsubtype alloc]init];
        subtype.tsubtypeid = [rs stringForColumn:@"id"];
        subtype.name = [rs stringForColumn:@"name"];
        subtype.image1 = [rs stringForColumn:@"image1"];
        subtype.typeid1 = [rs stringForColumn:@"typeid"];
        subtype.create_time = [rs stringForColumn:@"create_time"];
        subtype.update_time = [rs stringForColumn:@"update_time"];
        subtype.version = [rs stringForColumn:@"version"];
        [result addObject:subtype];
    }
    return result;
}

- (NSMutableArray *)getSubtypesDictByTypeID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tsubtype where typeid=%@", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *subtype = [[NSMutableDictionary alloc]init];
        [subtype setObject:[rs stringForColumn:@"id"] forKey:@"id"];
        [subtype setObject:[rs stringForColumn:@"name"] forKey:@"name"];
        [subtype setObject:[rs stringForColumn:@"image1"] forKey:@"image1"];
        [subtype setObject:[rs stringForColumn:@"typeid"] forKey:@"typeid1"];
        [subtype setObject:[rs stringForColumn:@"create_time"] forKey:@"create_time"];
        [subtype setObject:[rs stringForColumn:@"update_time"] forKey:@"update_time"];
        [subtype setObject:[rs stringForColumn:@"version"] forKey:@"version"];

        [result addObject:subtype];
    }
    return result;
}

@end
