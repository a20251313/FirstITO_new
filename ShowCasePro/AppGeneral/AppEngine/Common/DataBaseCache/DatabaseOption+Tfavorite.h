//
//  DatabaseOption+Tfavorite.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-24.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tproduct.h"

@interface DatabaseOption (Tfavorite)

- (NSArray *)monthsToSelect; // 月份

- (int)addFavoriteProduct:(Tproduct *)product;

- (NSArray *)selectFavoriteByYearMonth:(NSString *)yearmonth; // 当月所有收藏

- (NSArray *)selectFavoriteDetailsByDateID:(NSString *)dateid; // 当天所有收藏

- (int)deleteProductByDateID:(NSString *)dateid andProductid:(NSString *)productid; // 删除收藏的产品

- (BOOL)updateRemark:(NSString *)remark byTfavoriteID:(NSString *)tfavoriteid;

@end
