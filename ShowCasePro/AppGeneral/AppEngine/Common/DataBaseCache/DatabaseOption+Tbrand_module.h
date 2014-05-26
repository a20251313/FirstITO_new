//
//  DatabaseOption+Tbrand_module.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (Tbrand_module)

- (NSArray *)selectModuleNameByBrandID:(NSString *)brandid;
- (NSArray *)selectModuleNameByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech;
- (NSArray *)selectModuleNameByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech andTypeID:(NSString *)typeid1;
- (NSArray *)selectDataSourceByBrandID:(NSString *)brandid andIsNewTech:(NSString *)isnewtech andTypeID:(NSString *)typeid1;

@end
