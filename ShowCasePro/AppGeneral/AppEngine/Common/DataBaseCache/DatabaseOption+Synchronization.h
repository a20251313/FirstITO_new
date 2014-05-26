//
//  DatabaseOption+Synchronization.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-11.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (Synchronization)

- (BOOL)deleteDataByID:(NSString *)id1 inTable:(NSString *)tName;
- (BOOL)insertIntoTable:(NSString *)tName withParams:(NSDictionary *)params;

@end
