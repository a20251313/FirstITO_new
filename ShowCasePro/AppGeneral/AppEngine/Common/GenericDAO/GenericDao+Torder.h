//
//  GenericDao+Torder.h
//  ShowCasePro
//
//  Created by lvpw on 14-3-9.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "GenericDao.h"
#import "Torder.h"

@interface GenericDao (Torder)

/**
 *  保存购物车信息到订单表
 *
 *  @param order 订单对象（主键torderid为空）
 *  @param items 订单详细数组（torderitem对象）
 *
 *  @return 是否成功
 */
- (BOOL)saveCartToOrderByOrder:(Torder *)order andItems:(NSArray *)items;

/**
 *  删除保存的购物车内容
 *
 *  @param orderid 订单id
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteCartByOrderID:(NSInteger)orderid;

@end
