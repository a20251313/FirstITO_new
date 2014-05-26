//
//  DatabaseOption+condition.h
//  ShowCasePro
//
//  Created by CY-003 on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tproduct.h"

@interface DatabaseOption (condition)

- (Tproduct *) tProductByProductID:(NSString *)productID;

- (NSMutableArray *) productIDArrayByConditionSQL:(NSString*) conditionSQL;

- (NSMutableArray *) productArrayByConditionSQL:(NSString *) conditionSQL;

- (NSMutableArray *) productArrayByProductIDArray:(NSArray *) productIDArray;

@end
