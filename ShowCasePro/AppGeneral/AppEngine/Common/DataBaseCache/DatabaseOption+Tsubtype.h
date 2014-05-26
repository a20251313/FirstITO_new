//
//  DatabaseOption+Tsubtype.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-9.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (Tsubtype)

- (NSMutableArray *)getSubtypesByTypeID:(NSString *)value;

- (NSMutableArray *)getSubtypesDictByTypeID:(NSString *)value;

@end
