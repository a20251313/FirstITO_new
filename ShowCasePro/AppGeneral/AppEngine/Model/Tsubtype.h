//
//  tsubtype.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"

@interface Tsubtype : ObjectBase

@property (nonatomic, strong) NSString *tsubtypeid;
@property (nonatomic, strong) NSString *name; // 子类型名称
@property (nonatomic, strong) NSString *image1; // 图片
@property (nonatomic, strong) NSString *typeid1; // 产品大类ID
@property (nonatomic, strong) NSString *create_time; // 创建时间
@property (nonatomic, strong) NSString *update_time; // 更新时间
@property (nonatomic, strong) NSString *version; // 版本号

@end
