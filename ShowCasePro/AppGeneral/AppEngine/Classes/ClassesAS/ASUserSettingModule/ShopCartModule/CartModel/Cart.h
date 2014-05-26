//
//  Cart.h
//  CartDemo
//
//  Created by SUNMAC on 13-11-19.
//  Copyright (c) 2013年 lvpw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartItem.h"

@interface Cart : NSObject

@property double totalPrice; // 总价
@property (nonatomic, strong) NSString *type; // 操作属性
@property double discount; // 折扣
@property NSInteger goodsSize; // 商品总数
@property (nonatomic, strong) NSMutableDictionary *cart; // 产品item集合
@property (nonatomic, strong) NSMutableArray *goodsIDs; // 产品id集合

+ (Cart *)sharedInstance;
- (void)addProduct:(CartItem *)item AndCount:(NSInteger) count;
- (void)cutByPid:(NSString *)pid type:(NSString *)type;
- (void)addByPid:(NSString *)pid;
- (void)clear;

@end
