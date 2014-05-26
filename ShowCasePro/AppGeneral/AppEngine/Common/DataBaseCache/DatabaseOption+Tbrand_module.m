//
//  DatabaseOption+Tbrand_module.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Tbrand_module.h"
#import "DatabaseOption+Tvideo.h"
#import "Tbrandmodule.h"
#import "Tmodulepages.h"

@implementation DatabaseOption (Tbrand_module)

- (NSArray *)selectModuleNameByBrandID:(NSString *)brandid
{
    return [self selectModuleNameByBrandID:brandid andIsNewTech:@"0"];
}

- (NSArray *)selectModuleNameByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech
{
    return [self selectModuleNameByBrandID:brandid andIsNewTech:@"0" andTypeID:@"0"];
}

- (NSArray *)selectModuleNameByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech andTypeID:(NSString *)typeid1
{
    NSString *strSQL = @"select * from tbrand_module where brandid=? and isnew_tech=? and typeid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[brandid, isnewtech, typeid1]];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        [array addObject:[rs stringForColumn:@"module_name"]];
    }
    return array;
}

- (NSArray *)selectModuleByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech andTypeID:(NSString *)typeid1
{
    NSString *strSQL = @"select * from tbrand_module where brandid=? and isnew_tech=? and typeid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[brandid, isnewtech, typeid1]];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        Tbrandmodule *module = [[Tbrandmodule alloc]init];
        module.tbrandmoduleid = [rs stringForColumn:@"id"];
        module.module_name = [rs stringForColumn:@"module_name"];
        module.brandid = [rs stringForColumn:@"brandid"];
        module.desc = [rs stringForColumn:@"desc"];
        module.update_time = [rs stringForColumn:@"update_time"];
        module.isnew_tech = [rs stringForColumn:@"isnew_tech"];
        [array addObject:module];
    }
    return array;
}

- (NSArray *)selectDataSourceByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech andTypeID:(NSString *)typeid1
{
    NSArray *modules = [self selectModuleByBrandID:brandid andIsNewTech:(NSString *)isnewtech andTypeID:(NSString *)typeid1];
    NSString *strSQL = @"select * from tmodule_pages where moduleid=?";
    NSMutableArray *ds = [NSMutableArray array]; // 行
    [modules enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[((Tbrandmodule *)obj).tbrandmoduleid]];
        NSMutableArray *col = [NSMutableArray array]; // 列
        while ([rs next]) {
            Tmodulepages *modulepage = [[Tmodulepages alloc]init]; // 单个页面
            modulepage.tmodulepagesid = [rs stringForColumn:@"id"];
            modulepage.pageid = [rs stringForColumn:@"pageid"];
            modulepage.title = [rs stringForColumn:@"title"];
            modulepage.videoid = [rs stringForColumn:@"videoid"];
            modulepage.videosid = [rs stringForColumn:@"videosid"];
            if (modulepage.videosid!=nil && ![@"" isEqualToString:modulepage.videosid] && ![modulepage.videosid isEqual:[NSNull null]]) {
                modulepage.videos = [self selectVideosByIDs:modulepage.videosid];
            }
            modulepage.bgimg = [rs stringForColumn:@"bgimg"];
            modulepage.scrollerdesc = [rs stringForColumn:@"scrollerdesc"];
            modulepage.noscrollerdesc = [rs stringForColumn:@"noscrollerdesc"];
            modulepage.scrollerimage = [rs stringForColumn:@"scrollerimage"];
            modulepage.noscrollerimage = [rs stringForColumn:@"noscrollerimage"];
            modulepage.moduleid = [rs stringForColumn:@"moduleid"];
            modulepage.update_time = [rs stringForColumn:@"update_time"];
            modulepage.horizontalbigimg = [rs stringForColumn:@"horizontalbigimg"];
            modulepage.verticalbigimg = [rs stringForColumn:@"verticalbigimg"];
            [col addObject:modulepage];
        }
        [ds addObject:col];
    }];
    return ds;
}

@end
