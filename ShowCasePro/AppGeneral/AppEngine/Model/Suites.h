//
//  suites.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"

@interface Suites : ObjectBase

@property (nonatomic, strong) NSString *suiteid; //
@property (nonatomic, strong) NSString *name; // 系列名称
@property (nonatomic, strong) NSString *img1;
@property (nonatomic, strong) NSString *img2;
@property (nonatomic, strong) NSString *img3;
@property (nonatomic, strong) NSString *img4;
@property (nonatomic, strong) NSString *space1;
@property (nonatomic, strong) NSString *space2;
@property (nonatomic, strong) NSString *space3;
@property (nonatomic, strong) NSString *space4;
@property (nonatomic, strong) NSString *suites_logo; // 系列logo
@property (nonatomic, strong) NSString *intro; // 系列介绍
@property (nonatomic, strong) NSString *brand_id; // 品牌ID
@property (nonatomic, strong) NSString *video1; // 视频信息1
@property (nonatomic, strong) NSString *video2; // 视频信息2
@property (nonatomic, strong) NSString *video3; // 视频信息3
@property (nonatomic, strong) NSString *create_time; // 创建时间
@property (nonatomic, strong) NSString *update_time; // 更新时间
@property (nonatomic, strong) NSString *remark; // 备注
@property (nonatomic, strong) NSString *version; // 版本号

@end
