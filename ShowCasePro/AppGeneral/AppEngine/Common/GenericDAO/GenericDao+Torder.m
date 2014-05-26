//
//  GenericDao+Torder.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-9.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "GenericDao+Torder.h"
#import "TorderItem.h"

@implementation GenericDao (Torder)

- (BOOL)saveCartToOrderByOrder:(Torder *)order andItems:(NSArray *)items
{
    __block BOOL isRollBack = NO;
    [self.fmdb beginTransaction];
    @try {
        // 插入order
        BOOL b = [self insertWithObject:order];
        if (b) {
            // 取出插入order的orderid
            NSArray *arr = [self selectObjectsByStrSQL:@"select * from torder order by torderid desc limit 1" options:nil];
            int torderid = ((Torder *)arr[0]).torderid;
            
            // 会发生错误， database is locked,解决办法，用同一个dao即当前这个self
            // GenericDao *orderItemDAO = [[GenericDao alloc] initWithClassName:@"TorderItem"];
            [self changeClassName:@"TorderItem"];
            // 关联orderitem的torderid
            for (TorderItem *item in items) {
                item.torderid = torderid;
                // 插入torderItem表
                BOOL b1 = [self insertWithObject:item];
                if (!b1) {
                    // 一旦插入失败 回退
                    isRollBack = YES;
                    break;
                }
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [self.fmdb rollback];
    }
    @finally {
        if (!isRollBack) {
            [self.fmdb commit];
        }
    }
    return !isRollBack;
}


- (BOOL)deleteCartByOrderID:(NSInteger)orderid
{
    __block BOOL isRollBack = NO;
    // 事务删除，错误回滚
    [self.fmdb beginTransaction];
    @try {
        // 先删除详细表中的内容
        [self changeClassName:@"TorderItem"];
        BOOL b = [self deleteByProperty:@"torderid" withValue:[NSString stringWithFormat:@"%d", orderid]];
        if (b) {
            // 成功给你删除详细，开始删除主表中的内容Torder
            [self changeClassName:@"Torder"];
            if (![self deleteByProperty:@"torderid" withValue:[NSString stringWithFormat:@"%d", orderid]]) {
                isRollBack = YES;
            }
        } else {
            isRollBack = YES;
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [self.fmdb rollback];
    }
    @finally {
        if (!isRollBack) {
            [self.fmdb commit];
        }
    }
    return !isRollBack;
}

@end
