//
//  DatabaseOption+Tmodule_setting.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Tmodule_setting.h"

@implementation DatabaseOption (Tmodule_setting)

- (Tmodule_setting *)selectByBrandid:(NSString *)branid andTypeid:(NSString *)typeID
{
    NSString *strSQL = @"select * from tmodule_setting where 1=1 ";
    if (branid!=nil) {
        strSQL = [strSQL stringByAppendingFormat:@" and brandid=%@ ", branid];
    }
    if (typeID != nil) {
        strSQL = [strSQL stringByAppendingFormat:@" and typeid=%@ ", typeID];
    }
    
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    Tmodule_setting *moduleSetting = [[Tmodule_setting alloc] init];
    while ([rs next]) {
        moduleSetting.tmodule_settingid = [rs stringForColumn:@"id"];
        moduleSetting.module_name = [rs stringForColumn:@"module_name"];
        moduleSetting.brandid = [rs stringForColumn:@"brandid"];
        moduleSetting.ttypeid = [rs stringForColumn:@"typeid"];
        moduleSetting.banner1 = [rs stringForColumn:@"banner1"];
        moduleSetting.banner2 = [rs stringForColumn:@"banner2"];
        moduleSetting.banner3 = [rs stringForColumn:@"banner3"];
        moduleSetting.banner4 = [rs stringForColumn:@"banner4"];
        moduleSetting.online = [rs stringForColumn:@"new_online"];
        moduleSetting.collection = [rs stringForColumn:@"collection"];
        moduleSetting.techenoledge = [rs stringForColumn:@"techenoledge"];
        moduleSetting.product_show = [rs stringForColumn:@"product_show"];
        moduleSetting.other1 = [rs stringForColumn:@"other1"];
        moduleSetting.other2 = [rs stringForColumn:@"other2"];
        moduleSetting.other3 = [rs stringForColumn:@"other3"];
        moduleSetting.create_time = [rs stringForColumn:@"create_time"];
        moduleSetting.update_time = [rs stringForColumn:@"update_time"];
    }
    return moduleSetting;
}

@end
