//
//  DatabaseOption+Ttype.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-3.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Ttype.h"

@interface DatabaseOption (Ttype)

- (NSMutableArray *)brandType:(NSString *)brandid;
- (NSMutableArray *)getTypesBySuiteID:(NSString *)value;
- (NSMutableArray *)getTypesByProductIDs:(NSArray *)ids;
- (Ttype *)gettypeByTypeid:(NSString *)ttypeid;

@end
