//
//  ModuleProduct.h
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ObjectBase.h"

@interface ModuleProduct : ObjectBase

@property (nonatomic, strong) NSString *mp_id; // ID
@property (nonatomic, strong) NSString *space_id; // 空间ID
@property (nonatomic, strong) NSString *type_id; // 空间ID
@property (nonatomic, strong) NSString *product_id; // 品牌ID
@property (nonatomic, strong) NSString *product_ico;     //产品 + 号图片
@property (nonatomic, strong) NSString *product_position;  // 产品+号位置
@property (nonatomic, strong) NSString *update_time; //
@property (nonatomic, strong) NSString *product_detail;


@end
