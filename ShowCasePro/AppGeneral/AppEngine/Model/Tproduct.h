//
//  tproduct.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tproduct : NSObject

@property (nonatomic, strong) NSString *productid;
@property (nonatomic, strong) NSString *code; // 产品编号
@property (nonatomic, strong) NSString *name; // 中文名称
@property (nonatomic, strong) NSString *name_en; // 英文名称
@property (nonatomic, strong) NSString *pImg; // 产品图片
@property (nonatomic, strong) NSString *feature; // 特性
@property (nonatomic, strong) NSString *type1; // 产品大类
@property (nonatomic, strong) NSString *type2; // 所属于系列
@property (nonatomic, strong) NSString *type3; // 产品子类型
@property (nonatomic, strong) NSString *type4; // 龙头所述系列
@property (nonatomic, strong) NSString *brand; // 品牌
@property (nonatomic, strong) NSString *include_product; // 包括型号
@property (nonatomic, strong) NSString *create_time; // 添加时间
@property (nonatomic, strong) NSString *update_time; // 修改时间
@property (nonatomic, strong) NSString *param1; // 外观尺寸
@property (nonatomic, strong) NSString *param2; // 冲水方式
@property (nonatomic, strong) NSString *param3; // 冲水量
@property (nonatomic, strong) NSString *param4; // 坑距
@property (nonatomic, strong) NSString *param5; // 进／排水口标准间距
@property (nonatomic, strong) NSString *param6; // 要求水压
@property (nonatomic, strong) NSString *param7; // 供水方式
@property (nonatomic, strong) NSString *param8; // 供水压范围
@property (nonatomic, strong) NSString *param9; // 最大消费电力
@property (nonatomic, strong) NSString *param10; // 遥控器
@property (nonatomic, strong) NSString *param11; // 进水方式
@property (nonatomic, strong) NSString *param12; // 电力方式
@property (nonatomic, strong) NSString *param13; // 施工方式
@property (nonatomic, strong) NSString *param14; // 容量
@property (nonatomic, strong) NSString *param15; // 整体尺寸
@property (nonatomic, strong) NSString *param16; // 碗/台盆尺寸
@property (nonatomic, strong) NSString *param17; // 碗/台盆容量
@property (nonatomic, strong) NSString *param18; // 色号
@property (nonatomic, strong) NSString *param19; // 其他型号
@property (nonatomic, strong) NSString *param20; // 出水高度
@property (nonatomic, strong) NSString *param21; // 出水伸长 龙头
@property (nonatomic, strong) NSString *param22; // 抽拉管长度 龙头
@property (nonatomic, strong) NSString *param23; // 伊奈配件表面材
@property (nonatomic, strong) NSString *param24; // 伊奈配件内部芯材
@property (nonatomic, strong) NSString *param25; // 伊奈配件扶手支架外饰套
@property (nonatomic, strong) NSString *param26; // 伊奈配件各部连接套
@property (nonatomic, strong) NSString *param27; // 美标沐浴房 可选配件
@property (nonatomic, strong) NSString *param28; // 系列一览 骊住
@property (nonatomic, strong) NSString *param29; // 伊康佳数量
@property (nonatomic, strong) NSString *param30; // 伊康佳实际尺寸
@property (nonatomic, strong) NSString *param31; // 伊康佳厚度
@property (nonatomic, strong) NSString *param32; // 伊康佳所含内容
@property (nonatomic, strong) NSString *param33; // 骊住杰斯塔、万多斯产品等说明
@property (nonatomic, strong) NSString *param34; // 门把手
@property (nonatomic, strong) NSString *param35; // 玻璃款式
@property (nonatomic, strong) NSString *param36; // 所选款式
@property (nonatomic, strong) NSString *image1; // 产品图片1
@property (nonatomic, strong) NSString *image2; // 产品图片2
@property (nonatomic, strong) NSString *image3; // 产品图片3
@property (nonatomic, strong) NSString *image4; // 产品图片4
@property (nonatomic, strong) NSString *image5; // 产品图片5
@property (nonatomic, strong) NSString *version; // 版本号

@end
