//
//  DatabaseOption+condition.m
//  ShowCasePro
//
//  Created by CY-003 on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+condition.h"
#import "Tproduct.h"

@implementation DatabaseOption (condition)

-(NSMutableArray *)productArrayByProductIDArray:(NSArray *)productIDArray
{
    if (!productIDArray || ![productIDArray count])
    {
        NSLog(@"DatabaseOption+condition : productIDArray 有误 . ");
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *pid in productIDArray)
    {
        Tproduct *product = [self tProductByProductID:pid];
        
        if (product) {
            [array addObject:product];
        }
        
    }
    
    if (!array.count) {
        return nil;
    }
    return array;
}


-(Tproduct *)tProductByProductID:(NSString *)productID
{
    return [self productArrayByConditionSQL:[NSString stringWithFormat:@"SELECT * FROM tproduct WHERE id = %@ and param31=1 ", productID]][0];
}

-(NSMutableArray *)productIDArrayByConditionSQL:(NSString *)conditionSQL
{
    if (!conditionSQL || [conditionSQL isEqualToString:@""])
    {
        NSLog(@"DatabaseOption+condition : sql 语句错误 . ");
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    FMResultSet *set = [self.fmdb executeQuery:conditionSQL];
    
    while ([set next])
    {
        NSString *productID = [set stringForColumn:@"id"];
        [result addObject:productID];
    }
    
//    NSLog(@"DatabaseOption+condition : productID 数: %d",[result count]);
    return result;
}


-(NSMutableArray *)productArrayByConditionSQL:(NSString *)conditionSQL
{
    if (!conditionSQL || [conditionSQL isEqualToString:@""])
    {
        NSLog(@"DatabaseOption+condition : sql 语句错误 . ");
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    FMResultSet *set = [self.fmdb executeQuery:conditionSQL];
    
    while ([set next])
    {
        Tproduct *product = [[Tproduct alloc] init];
        
        product.productid       = [set stringForColumn:@"id"];
        product.code            = [set stringForColumn:@"code"]; // 产品编号
        product.name            = [set stringForColumn:@"name"]; // 中文名称
        product.name_en         = [set stringForColumn:@"name_en"]; // 英文名称
        product.pImg            = [set stringForColumn:@"pImg"]; // 产品图片
        product.feature         = [set stringForColumn:@"feature"]; // 特性
        product.type1           = [set stringForColumn:@"type1"]; // 产品大类
        product.type2           = [set stringForColumn:@"type2"]; // 所属于系列
        product.type3           = [set stringForColumn:@"type3"]; // 产品子类型
        product.type4           = [set stringForColumn:@"type4"]; // 龙头所述系列
        product.brand           = [set stringForColumn:@"brand"]; // 品牌
        product.include_product = [set stringForColumn:@"include_product"]; // 包括型号
        product.create_time     = [set stringForColumn:@"create_time"]; // 添加时间
        product.update_time     = [set stringForColumn:@"update_time"]; // 修改时间
        product.param1          = [set stringForColumn:@"param1"]; // 外观尺寸
        product.param2          = [set stringForColumn:@"param2"]; // 冲水方式
        product.param3          = [set stringForColumn:@"param3"]; // 冲水量
        product.param4          = [set stringForColumn:@"param4"]; // 坑距
        product.param5          = [set stringForColumn:@"param5"]; // 进／排水口标准间距
        product.param6          = [set stringForColumn:@"param6"]; // 要求水压
        product.param7          = [set stringForColumn:@"param7"]; // 供水方式
        product.param8          = [set stringForColumn:@"param8"]; // 供水压范围
        product.param9          = [set stringForColumn:@"param9"]; // 最大消费电力
        product.param10         = [set stringForColumn:@"param10"]; // 遥控器
        product.param11         = [set stringForColumn:@"param11"]; // 进水方式
        product.param12         = [set stringForColumn:@"param12"]; // 电力方式
        product.param13         = [set stringForColumn:@"param13"]; // 施工方式
        product.param14         = [set stringForColumn:@"param14"]; // 容量
        product.param15         = [set stringForColumn:@"param15"]; // 整体尺寸
        product.param16         = [set stringForColumn:@"param16"]; // 碗/台盆尺寸
        product.param17         = [set stringForColumn:@"param17"]; // 碗/台盆容量
        product.param18         = [set stringForColumn:@"param18"]; // 色号
        product.param19         = [set stringForColumn:@"param19"]; // 其他型号
        product.param20         = [set stringForColumn:@"param20"]; // 出水高度
        product.param21         = [set stringForColumn:@"param21"]; // 出水伸长 龙头
        product.param22         = [set stringForColumn:@"param22"]; // 抽拉管长度 龙头
        product.param23         = [set stringForColumn:@"param23"]; // 伊奈配件表面材
        product.param24         = [set stringForColumn:@"param24"]; // 伊奈配件内部芯材
        product.param25         = [set stringForColumn:@"param25"]; // 伊奈配件扶手支架外饰套
        product.param26         = [set stringForColumn:@"param26"]; // 伊奈配件各部连接套
        product.param27         = [set stringForColumn:@"param27"]; // 美标沐浴房 可选配件
        product.param28         = [set stringForColumn:@"param28"]; // 系列一览 骊住
        product.param29         = [set stringForColumn:@"param29"]; // 伊康佳数量
        product.param30         = [set stringForColumn:@"param30"]; // 伊康佳实际尺寸
        product.param31         = [set stringForColumn:@"param31"]; // 伊康佳厚度
        product.param32         = [set stringForColumn:@"param32"]; // 伊康佳所含内容
        product.param33         = [set stringForColumn:@"param33"]; // 骊住杰斯塔、万多斯产品等说明
        product.param34         = [set stringForColumn:@"param34"]; // 门把手
        product.param35         = [set stringForColumn:@"param35"]; // 玻璃款式
        product.param36         = [set stringForColumn:@"param36"]; // 所选款式
        product.image1          = [set stringForColumn:@"image1"];  //产品大图
        product.image2          = [set stringForColumn:@"image2"];
        product.image3          = [set stringForColumn:@"image3"];
        product.image4          = [set stringForColumn:@"image4"];
        product.image5          = [set stringForColumn:@"image5"];  //产品施工图
        product.version         = [set stringForColumn:@"version"]; // 版本号
        
        [result addObject:product];
    }
    
//    NSLog(@"DatabaseOption+condition : product 数: %d",[result count]);
    if (!result.count) {
        return nil;
    }
    return result;
}

@end
