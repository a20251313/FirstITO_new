//
//  ttype.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"

@interface Ttype : ObjectBase

@property (nonatomic, strong) NSString *ttypeid;
@property (nonatomic, strong) NSString *name; // 分类名称
@property (nonatomic, strong) NSString *image; // 图片
@property (nonatomic, strong) NSString *product_id; // 父类ID
@property (nonatomic, strong) NSString *b_id; // 所属品牌
@property (nonatomic, strong) NSString *create_time; // 创建时间
@property (nonatomic, strong) NSString *update_time; // 更新时间
@property (nonatomic, strong) NSString *remark; // 备注
@property (nonatomic, strong) NSString *version; // 版本号

@end
