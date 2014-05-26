//
//  DatabaseOption+Union.h
//  ShowCasePro
//
//  Created by CY-003 on 13-12-19.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (Union)

- (NSArray *) union_productIDArrayWithProductID:(NSString *)productid  type:(NSString *)type;

@end
