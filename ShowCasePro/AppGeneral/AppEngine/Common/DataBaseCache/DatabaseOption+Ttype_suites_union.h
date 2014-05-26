//
//  DatabaseOption+Ttype_suites_union.h
//  ShowCasePro
//
//  Created by lvpw on 14-1-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (Ttype_suites_union)

- (NSMutableArray *)selectByTypeid:(NSString *)typeID; // 返回suites集合

@end
