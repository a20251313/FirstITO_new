//
//  TorderItem.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-9.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TorderItem : NSObject

@property (nonatomic) NSInteger torderitemid; // item id
@property (nonatomic, strong) NSString *productid; // 产品id
@property (nonatomic) NSInteger subquentity; // 总数量
@property (nonatomic) double subprice; // 总价
@property (nonatomic) double subpriceunit; // 单价
@property (nonatomic) NSInteger torderid; // 订单id

@end
