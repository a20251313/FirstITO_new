//
//  CartItem.h
//  CartDemo
//
//  Created by SUNMAC on 13-11-19.
//  Copyright (c) 2013年 lvpw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tproduct.h"

@interface CartItem : NSObject

@property NSInteger subQuentity; // 总数量
@property double subPrice; // 总价
@property double subPriceUnit; // 每个good单价
@property (nonatomic, strong)Tproduct *good;
@property BOOL duihaoStatus; // 对号状态 -> yes:隐藏 no:不隐藏

@end
