//
//  DatabaseOption+Suites.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-3.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Suites.h"
#import "GenericDao.h"

@implementation DatabaseOption (Suites)

- (NSMutableArray *)allSuites
{
    NSString *strSQL = @"select * from suites";
    return [self getSuitesByStrSQL:strSQL];
//    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
//    NSMutableArray *result =[NSMutableArray array];
//    while ([rs next]) {
//        Suites *suit = [[Suites alloc]init];
//        suit.suiteid = [rs stringForColumn:@"id"];
//        suit.name = [rs stringForColumn:@"name"];
//        suit.suites_logo = [rs stringForColumn:@"suites_logo"];
//        suit.intro = [rs stringForColumn:@"intro"];
//        suit.brand_id = [rs stringForColumn:@"brand_id"];
//        suit.video1 = [rs stringForColumn:@"video1"];
//        suit.video2 = [rs stringForColumn:@"video2"];
//        suit.video3 = [rs stringForColumn:@"video3"];
//        suit.create_time = [rs stringForColumn:@"create_time"];
//        suit.update_time = [rs stringForColumn:@"update_time"];
//        suit.remark = [rs stringForColumn:@"remark"];
//        suit.version = [rs stringForColumn:@"version"];
//        [result addObject:suit];
//    }
//    return result;
}

- (NSMutableArray *)getSuitesByTypeID:(NSString *)value{
    NSString *strSQL = [NSString stringWithFormat:@"select * from suites where id in (select distinct(type2) from tproduct where type1=%@ and param31 = 1)", value];
    return [self getSuitesByStrSQL:strSQL];
//    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
//    NSMutableArray *result =[NSMutableArray array];
//    while ([rs next]) {
//        Suites *suit = [[Suites alloc]init];
//        suit.suiteid = [rs stringForColumn:@"id"];
//        suit.name = [rs stringForColumn:@"name"];
//        suit.suites_logo = [rs stringForColumn:@"suites_logo"];
//        suit.intro = [rs stringForColumn:@"intro"];
//        suit.brand_id = [rs stringForColumn:@"brand_id"];
//        suit.video1 = [rs stringForColumn:@"video1"];
//        suit.video2 = [rs stringForColumn:@"video2"];
//        suit.video3 = [rs stringForColumn:@"video3"];
//        suit.create_time = [rs stringForColumn:@"create_time"];
//        suit.update_time = [rs stringForColumn:@"update_time"];
//        suit.remark = [rs stringForColumn:@"remark"];
//        suit.version = [rs stringForColumn:@"version"];
//        [result addObject:suit];
//    }
//    return result;
}

- (NSMutableArray *)getSuitesByBrandID:(NSString *)value{
    NSString *strSQL = [NSString stringWithFormat:@"select * from suites where brand_id=%@ and suites_logo !=''", value];
    return [self getSuitesByStrSQL:strSQL];
}

- (NSMutableArray *)getSuitesByStrSQL:(NSString *)strSQL{
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result =[NSMutableArray array];
    while ([rs next]) {
        Suites *suit = [[Suites alloc]init];
        suit.suiteid = [rs stringForColumn:@"id"];
        suit.name = [rs stringForColumn:@"name"];
        suit.img1 = [rs stringForColumn:@"img1"];
        suit.img2 = [rs stringForColumn:@"img2"];
        suit.img3 = [rs stringForColumn:@"img3"];
        suit.img4 = [rs stringForColumn:@"img4"];
        suit.space1 = [rs stringForColumn:@"space1"];
        suit.space2 = [rs stringForColumn:@"space2"];
        suit.space3 = [rs stringForColumn:@"space3"];
        suit.space4 = [rs stringForColumn:@"space4"];
        suit.suites_logo = [rs stringForColumn:@"suites_logo"];
        suit.intro = [rs stringForColumn:@"intro"];
        suit.brand_id = [rs stringForColumn:@"brand_id"];
        suit.video1 = [rs stringForColumn:@"video1"];
        suit.video2 = [rs stringForColumn:@"video2"];
        suit.video3 = [rs stringForColumn:@"video3"];
        suit.create_time = [rs stringForColumn:@"create_time"];
        suit.update_time = [rs stringForColumn:@"update_time"];
        suit.remark = [rs stringForColumn:@"remark"];
        suit.version = [rs stringForColumn:@"version"];
        [result addObject:suit];
    }
    return result;
}

- (NSMutableArray *)getSuitesDictByBrandID:(NSString *)value
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from suites where brand_id=%@ and suites_logo !=''", value];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result =[NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *suit = [NSMutableDictionary dictionary];
        [suit setObject:[rs stringForColumn:@"id"] forKey:@"id"];
        [suit setObject:[rs stringForColumn:@"name"] forKey:@"name"];
        [suit setObject:[rs stringForColumn:@"img1"] forKey:@"img1"];
        [suit setObject:[rs stringForColumn:@"img2"] forKey:@"img2"];
        [suit setObject:[rs stringForColumn:@"img3"] forKey:@"img3"];
        [suit setObject:[rs stringForColumn:@"img4"] forKey:@"img4"];
        [suit setObject:[rs stringForColumn:@"suites_logo"] forKey:@"suites_logo"];
        [suit setObject:[rs stringForColumn:@"intro"] forKey:@"intro"];
        [suit setObject:[rs stringForColumn:@"brand_id"] forKey:@"brand_id"];
        [suit setObject:[rs stringForColumn:@"video1"] forKey:@"video1"];
        [suit setObject:[rs stringForColumn:@"video2"] forKey:@"video2"];
        [suit setObject:[rs stringForColumn:@"video3"] forKey:@"video3"];
        [suit setObject:[rs stringForColumn:@"create_time"] forKey:@"create_time"];
        [suit setObject:[rs stringForColumn:@"update_time"] forKey:@"update_time"];
        [suit setObject:[rs stringForColumn:@"remark"] forKey:@"remark"];
        [suit setObject:[rs stringForColumn:@"version"] forKey:@"version"];
 
        [result addObject:suit];
    }
    return result;
}


- (Suites *)getSuiteBysuiteid:(NSString *)suiteid
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from suites where id=%@", suiteid];
    return [self getSuitesByStrSQL:strSQL][0];
}

- (NSMutableArray *)getSuitesByProductIDs:(NSArray *)ids
{
    NSString *strSQL = @"select * from suites where id in (select distinct(type2) from tproduct where brand=2 and param31 = 1 and ";
    if (ids.count>0) {
        strSQL = [strSQL stringByAppendingString:@"("];
    }
    for (NSString *productid in ids) {
        strSQL = [strSQL stringByAppendingFormat:@" id=%@ or ", productid];
    }
    strSQL = [strSQL substringToIndex:strSQL.length-3];
    strSQL = [strSQL stringByAppendingString:@"))"];
    
    GenericDao *dao = [[GenericDao alloc] initWithClassName:@"Suites"];
    return [dao selectObjectsByStrSQL:strSQL options:@{@"suiteid": @"id"}];
}

@end
