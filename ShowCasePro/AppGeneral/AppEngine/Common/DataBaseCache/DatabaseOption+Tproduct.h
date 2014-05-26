//
//  DatabaseOption+Tproduct.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-4.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (Tproduct)

- (NSMutableArray *)selectProductByProductID:(NSString *)pid;

- (NSMutableArray *)selectProductByProductIDs:(NSArray *)pids;

- (NSMutableArray *)selectProductsByType:(NSString *)type andValue:(NSString *)v;

- (NSMutableArray *)selectProductsByType:(NSString *)type andValue:(NSString *)v params:(NSDictionary *)params;

- (NSMutableArray *)selectProductByparams:(NSMutableArray *)params;

@end
