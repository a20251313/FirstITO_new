//
//  Tsuites_type.h
//  ShowCasePro
//
//  Created by lvpw on 14-1-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ObjectBase.h"

@interface Tsuites_type : ObjectBase

@property (nonatomic, strong) NSString *tsuites_typeid;
@property (nonatomic, strong) NSString *suitesid;
@property (nonatomic, strong) NSString *subtype_name;
@property (nonatomic, strong) NSString *image; // 图片
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *update_time;

@end
