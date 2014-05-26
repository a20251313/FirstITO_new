//
//  DatabaseOption+Tsuite_space.h
//  ShowCasePro
//
//  Created by lvpw on 14-1-12.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tsuite_space.h"

@interface DatabaseOption (Tsuite_space)

- (NSMutableArray *)selectSpacesBySuiteID:(NSString *)suiteid;

@end
