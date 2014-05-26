//
//  DatabaseOption+Suites.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-3.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Suites.h"

@interface DatabaseOption (Suites)

- (NSMutableArray *)allSuites;
- (NSMutableArray *)getSuitesByTypeID:(NSString *)value;
- (NSMutableArray *)getSuitesByBrandID:(NSString *)value;
- (Suites *)getSuiteBysuiteid:(NSString *)suiteid;

- (NSMutableArray *)getSuitesDictByBrandID:(NSString *)value;

- (NSMutableArray *)getSuitesByProductIDs:(NSArray *)ids;

@end
