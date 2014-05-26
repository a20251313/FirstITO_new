//
//  DatabaseOption+Ttype.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-3.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Ttype.h"
#import "Ttype.h"
#import "GenericDao.h"

@implementation DatabaseOption (Ttype)

- (NSMutableArray *)brandType:(NSString *)brandid
{
    NSString *strSQL = nil;
    if ([brandid isEqualToString:@"2"]) strSQL = @"select * from ttype where b_id=2 and product_id=2 order by orderby";
    else if([brandid isEqualToString:@"3"]) strSQL = @"select * from ttype where b_id=3 and product_id=0";
    else if ([brandid isEqualToString:@"1"]) strSQL = @"select * from ttype where b_id=1 and product_id=0";
    
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *results = [NSMutableArray array];
    while ([rs next]) {
        Ttype *type = [[Ttype alloc]init];
        type.ttypeid = [rs stringForColumn:@"id"];
        type.name = [rs stringForColumn:@"name"];
        type.image = [rs stringForColumn:@"image"];
        type.product_id = [rs stringForColumn:@"product_id"];
        type.b_id = [rs stringForColumn:@"b_id"];
        type.create_time = [rs stringForColumn:@"create_time"];
        type.update_time = [rs stringForColumn:@"update_time"];
        type.remark = [rs stringForColumn:@"remark"];
        type.version = [rs stringForColumn:@"version"];
        [results addObject:type];
    }
    return results;
}

- (NSMutableArray *)getTypesBySuiteID:(NSString *)value{
    NSString *strSQL = [NSString stringWithFormat:@"select * from ttype where id in (select distinct(type1) from tproduct where type2=%@ and param31 = 1)", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *results = [NSMutableArray array];
    while ([rs next]) {
        Ttype *type = [[Ttype alloc]init];
        type.ttypeid = [rs stringForColumn:@"id"];
        type.name = [rs stringForColumn:@"name"];
        type.image = [rs stringForColumn:@"image"];
        type.product_id = [rs stringForColumn:@"product_id"];
        type.b_id = [rs stringForColumn:@"b_id"];
        type.create_time = [rs stringForColumn:@"create_time"];
        type.update_time = [rs stringForColumn:@"update_time"];
        type.remark = [rs stringForColumn:@"remark"];
        type.version = [rs stringForColumn:@"version"];
        [results addObject:type];
    }
    return results;
}

- (NSMutableArray *)getTypesByProductIDs:(NSArray *)ids
{
    NSString *strSQL = @"select * from ttype where id in (select distinct(type1) from tproduct where brand=2 and param31 = 1 and ";
    if (ids.count>0) {
        strSQL = [strSQL stringByAppendingString:@"("];
    }
    for (NSString *productid in ids) {
        strSQL = [strSQL stringByAppendingFormat:@" id=%@ or ", productid];
    }
    strSQL = [strSQL substringToIndex:strSQL.length-3];
    strSQL = [strSQL stringByAppendingString:@"))"];
    strSQL = [strSQL stringByAppendingString:@" order by orderby"];
    GenericDao *DAO = [[GenericDao alloc] initWithClassName:@"Ttype"];
    
    return [DAO selectObjectsByStrSQL:strSQL options:@{@"ttypeid": @"id"}];
}

- (Ttype *)gettypeByTypeid:(NSString *)ttypeid
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from ttype where id=%@", ttypeid];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    Ttype *type = [[Ttype alloc]init];
    while ([rs next]) {
        type.ttypeid = [rs stringForColumn:@"id"];
        type.name = [rs stringForColumn:@"name"];
        type.image = [rs stringForColumn:@"image"];
        type.product_id = [rs stringForColumn:@"product_id"];
        type.b_id = [rs stringForColumn:@"b_id"];
        type.create_time = [rs stringForColumn:@"create_time"];
        type.update_time = [rs stringForColumn:@"update_time"];
        type.remark = [rs stringForColumn:@"remark"];
        type.version = [rs stringForColumn:@"version"];
    }
    return type;
}

@end
