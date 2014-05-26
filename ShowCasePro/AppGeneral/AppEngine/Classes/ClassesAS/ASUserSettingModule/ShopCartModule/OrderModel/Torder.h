//
//  Torder.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-9.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Torder : NSObject

@property (nonatomic) NSInteger torderid; // 订单id
@property (nonatomic, strong) NSString *remark; // 备注
@property (nonatomic, strong) NSString *update_time; // 更新时间
@property (nonatomic, strong) NSString *create_time; // 创建时间
@property (nonatomic) double totalprice; // 总价
@property (nonatomic) NSInteger goodssize; // 商品总数量
@property (nonatomic, strong) NSString *userid;

@end
