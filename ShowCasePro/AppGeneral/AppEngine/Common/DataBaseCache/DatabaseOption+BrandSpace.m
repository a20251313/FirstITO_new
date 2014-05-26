//
//  DatabaseOption+BrandModule.m
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+BrandSpace.h"

@implementation DatabaseOption (BrandSpace)


- (NSMutableArray *)getModuleSpaceList:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tbrand_space where brandid = '%@' order by orderby", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        BrandSpace *space = [[BrandSpace alloc] init];
        space.spaceID = [rs stringForColumn:@"id"];
        space.suiteid = [rs stringForColumn:@"suiteid"];
        space.brandid = [rs stringForColumn:@"brandid"];
        space.name = [rs stringForColumn:@"name"];
        space.descripts = [rs stringForColumn:@"descripts"];
        space.designer_descripte = [rs stringForColumn:@"designer_descript"];
        space.designer_ico = [rs stringForColumn:@"designer_ico"];
        space.space_image = [rs stringForColumn:@"space_image"];
        space.space_module = [rs stringForColumn:@"space_module"];
        space.update_time = [rs stringForColumn:@"update_time"];
        
        space.suite_ico = [rs stringForColumn:@"suite_ico"];
        space.suite_des = [rs stringForColumn:@"suite_des"];
        space.suite_colore = [rs stringForColumn:@"suite_color"];
        
        space.ico_bg = [rs stringForColumn:@"ico_bg"];
        
        [arr addObject:space];
    }
    return arr;
}

- (BrandSpace *)getModuleSpaceBySuiteID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tbrand_space where suiteid = '%@'", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        BrandSpace *space = [[BrandSpace alloc] init];
        space.spaceID = [rs stringForColumn:@"id"];
        space.suiteid = [rs stringForColumn:@"suiteid"];
        space.brandid = [rs stringForColumn:@"brandid"];
        space.name = [rs stringForColumn:@"name"];
        space.descripts = [rs stringForColumn:@"descripts"];
        space.designer_descripte = [rs stringForColumn:@"designer_descript"];
        space.designer_ico = [rs stringForColumn:@"designer_ico"];
        space.space_image = [rs stringForColumn:@"space_image"];
        space.space_module = [rs stringForColumn:@"space_module"];
        space.update_time = [rs stringForColumn:@"update_time"];
        space.suite_ico = [rs stringForColumn:@"suite_ico"];
        space.suite_des = [rs stringForColumn:@"suite_des"];
        space.suite_colore = [rs stringForColumn:@"suite_color"];
        
        space.ico_bg = [rs stringForColumn:@"ico_bg"];
        
        [arr addObject:space];
    }
    return arr[0];
}



//@property (nonatomic, strong) NSString *spaceID; // 空间ID
//@property (nonatomic, strong) NSString *suiteid; // 系列ID
//@property (nonatomic, strong) NSString *brandid; // 品牌ID
//@property (nonatomic, strong) NSString *name;     //空间名称
//@property (nonatomic, strong) NSString *descripts;  // 空间描述
//@property (nonatomic, strong) NSString *designer_descripte;  // 描述
//@property (nonatomic, strong) NSString *designer_ico; // 设计师头像
//@property (nonatomic, strong) NSString *space_image; // 空间平面图
//@property (nonatomic, strong) NSString *space_module; // 3d模型
//@property (nonatomic, strong) NSString *update_time; //
//

@end
