//
//  DatabaseOption+BrandModule.h
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "BrandSpace.h"

@interface DatabaseOption (BrandSpace)

- (NSMutableArray *)getModuleSpaceList:(NSString *)value;

- (BrandSpace *)getModuleSpaceBySuiteID:(NSString *)value;


@end
