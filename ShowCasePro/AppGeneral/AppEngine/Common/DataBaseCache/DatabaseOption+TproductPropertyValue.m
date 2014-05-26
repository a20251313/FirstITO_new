//
//  DatabaseOption+TproductPropertyValue.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+TproductPropertyValue.h"
#import "TproductPropertyValue.h"

@implementation DatabaseOption (TproductPropertyValue)

- (NSMutableArray *)getPropertyValueByPropertyID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tproduct_property_value where propertyid=%@", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        TproductPropertyValue *propertyValue = [[TproductPropertyValue alloc]init];
        propertyValue.tproductPropertyValueid = [rs stringForColumn:@"id"];
        propertyValue.value = [rs stringForColumn:@"value"];
        propertyValue.propertyid = [rs stringForColumn:@"propertyid"];
        propertyValue.update_time = [rs stringForColumn:@"update_time"];
        propertyValue.version = [rs stringForColumn:@"version"];
        [result addObject:propertyValue];
    }
    return result;
}

- (NSMutableArray *)getPropertyValueDictByPropertyID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tproduct_property_value where propertyid=%@", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *propertyValue = [NSMutableDictionary dictionary];
        [propertyValue setObject:[rs stringForColumn:@"id"] forKey:@"id"];
        [propertyValue setObject:[rs stringForColumn:@"value"] forKey:@"name"];
        [propertyValue setObject:[rs stringForColumn:@"propertyid"] forKey:@"propertyid"];
        [propertyValue setObject:[rs stringForColumn:@"update_time"] forKey:@"update_time"];
        [propertyValue setObject:[rs stringForColumn:@"version"] forKey:@"version"];

        [result addObject:propertyValue];
    }
    return result;
}

@end
