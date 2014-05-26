//
//  DatabaseOption+TproductProperty.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+TproductProperty.h"
#import "TproductProperty.h"

@implementation DatabaseOption (TproductProperty)

- (NSMutableArray *)getPropertyByTypeID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tproduct_property where typeid=%@", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        TproductProperty *property = [[TproductProperty alloc]init];
        property.propertyid = [rs stringForColumn:@"id"];
        property.name = [rs stringForColumn:@"name"];
        property.typeid1 = [rs stringForColumn:@"typeid"];
        property.update_time = [rs stringForColumn:@"update_time"];
        property.version = [rs stringForColumn:@"version"];
        property.searchkey = [rs stringForColumn:@"searchkey"];
        
        [result addObject:property];
    }
    return result;
}

@end
