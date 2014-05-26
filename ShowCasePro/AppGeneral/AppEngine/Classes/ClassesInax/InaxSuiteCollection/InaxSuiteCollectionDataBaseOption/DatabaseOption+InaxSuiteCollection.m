//
//  DatabaseOption+InaxSuiteCollection.m
//  ShowCasePro
//
//  Created by Mac on 14-3-23.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+InaxSuiteCollection.h"
#import "InaxSuiteCollection.h"

@implementation DatabaseOption (InaxSuiteCollection)

-(NSArray *)inaxSuiteCollectionArray
{
    NSString *sql = [NSString stringWithFormat:@"select * from t_inax_suites_collection where brand_id = %@ order by orderby",[LibraryAPI sharedInstance].currentBrandID];
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    while ([set next])
    {
        InaxSuiteCollection *suiteCollection = [InaxSuiteCollection new];
        
        suiteCollection.InaxSuiteCollectionID   = [set stringForColumn:@"id"];
        suiteCollection.name                    = [set stringForColumn:@"name"];
        suiteCollection.suite_id                = [set stringForColumn:@"suite_id"];
        suiteCollection.type_id                 = [set stringForColumn:@"type_id"];
        suiteCollection.des_image               = [set stringForColumn:@"des_image"];
        suiteCollection.detail_image            = [set stringForColumn:@"detail_image"];
        suiteCollection.bg_image                = [set stringForColumn:@"bg_image"];
        suiteCollection.update_time             = [set stringForColumn:@"update_time"];
        suiteCollection.orderby                 = [set stringForColumn:@"orderby"];
        suiteCollection.brand_id                = [set stringForColumn:@"brand_id"];
        
        [dataArray addObject:suiteCollection];
    }
    
    if (!dataArray.count) {
        return nil;
    }
    
    return dataArray;
}

@end
