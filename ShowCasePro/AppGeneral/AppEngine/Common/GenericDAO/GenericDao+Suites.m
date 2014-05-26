//
//  GenericDao+Suites.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-5.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "GenericDao+Suites.h"

@implementation GenericDao (Suites)

- (NSMutableArray *)selectASCollectionsByOptions:(NSDictionary *)options
{
    NSString *strSQL = @"select * from suites where brand_id = 2 and version !=0 order by version";
    NSMutableArray *arr = [self selectObjectsByStrSQL:strSQL options:options];
    return arr;
}

@end
