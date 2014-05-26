//
//  DatabaseOption+TproductPropertyValue.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

@interface DatabaseOption (TproductPropertyValue)

- (NSMutableArray *)getPropertyValueByPropertyID:(NSString *)value;

- (NSMutableArray *)getPropertyValueDictByPropertyID:(NSString *)value;

@end
