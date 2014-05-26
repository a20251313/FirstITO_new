//
//  DatabaseOption+ModuleProduct.m
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+ModuleProduct.h"
#import "ModuleProduct.h"


@implementation DatabaseOption (ModuleProduct)


- (NSMutableArray *)getSpaceProductBySpaceID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from t_module_product where space_id = '%@'", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        ModuleProduct *mpProduct = [[ModuleProduct alloc] init];
        mpProduct.mp_id = [rs stringForColumn:@"id"];
        mpProduct.space_id = [rs stringForColumn:@"space_id"];
        mpProduct.type_id = [rs stringForColumn:@"type_id"];
        mpProduct.product_id = [rs stringForColumn:@"product_id"];
        mpProduct.product_ico = [rs stringForColumn:@"product_ico"];
        mpProduct.product_position = [rs stringForColumn:@"product_position"];
        mpProduct.update_time = [rs stringForColumn:@"update_time"];
        mpProduct.product_detail = [rs stringForColumn:@"product_detail"];
        [arr addObject:mpProduct];
    }
    return arr;
}

//@property (nonatomic, strong) NSString *mp_id; // ID
//@property (nonatomic, strong) NSString *space_id; // 空间ID
//@property (nonatomic, strong) NSString *product_id; // 品牌ID
//@property (nonatomic, strong) NSString *product_ico;     //产品 + 号图片
//@property (nonatomic, strong) NSString *product_position;  // 产品+号位置
//@property (nonatomic, strong) NSString *update_time; //


@end
