//
//  BrandSpace.h
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ObjectBase.h"

@interface BrandSpace : NSObject

@property (nonatomic, strong) NSString *spaceID; // 空间ID
@property (nonatomic, strong) NSString *suiteid; // 系列ID
@property (nonatomic, strong) NSString *brandid; // 品牌ID
@property (nonatomic, strong) NSString *name;     //空间名称
@property (nonatomic, strong) NSString *descripts;  // 空间描述
@property (nonatomic, strong) NSString *designer_descripte;  // 描述
@property (nonatomic, strong) NSString *designer_ico; // 设计师头像
@property (nonatomic, strong) NSString *space_image; // 空间平面图
@property (nonatomic, strong) NSString *space_module; // 3d模型
@property (nonatomic, strong) NSString *update_time; //

@property (nonatomic, strong) NSString *suite_ico; // 系列标题ICO
@property (nonatomic, strong) NSString *suite_des; //  系列描述
@property (nonatomic, strong) NSString *suite_colore; //  空间色调图

@property (nonatomic, strong) NSString *ico_bg; //  设计师和3Droom icon背景图片



@end
