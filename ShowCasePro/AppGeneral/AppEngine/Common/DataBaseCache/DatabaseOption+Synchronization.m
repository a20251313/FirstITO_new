//
//  DatabaseOption+Synchronization.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-11.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Synchronization.h"

@implementation DatabaseOption (Synchronization)

- (BOOL)deleteDataByID:(NSString *)id1 inTable:(NSString *)tName{
    NSString *strSQL = [NSString stringWithFormat:@"delete from %@ where id=%@", tName, id1];
//    NSLog(@"delete:>>%@", strSQL);
    
    if ([strSQL contains:@"admin"]) {
        strSQL = [NSString stringWithFormat:@"delete from %@ where userid=%@", tName, id1];
    }
    
    return [self.fmdb executeUpdate:strSQL];
//    return false;
}

//- (BOOL)insertIntoTable:(NSString *)tName withParams:(NSDictionary *)params{
//    __block NSString *strSQL = [NSString stringWithFormat:@"insert into %@ (", tName];
//    __block NSString *strSQL1 = [NSString stringWithFormat:@" values ("];
//    
//    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        strSQL = [strSQL stringByAppendingString:[NSString stringWithFormat:@"%@, ", (NSString *)key]];
//        strSQL1 = [strSQL1 stringByAppendingString:[NSString stringWithFormat:@"'%@', ", (NSString *)obj]];
//    }];
//    strSQL = [strSQL substringToIndex:strSQL.length-2];
//    strSQL1 = [strSQL1 substringToIndex:strSQL1.length-2];
//    
//    strSQL = [strSQL stringByAppendingString:[NSString stringWithFormat:@") %@)", strSQL1]];
////    NSLog(@"insert:>>%@", strSQL);
//    BOOL b = [self.fmdb executeUpdate:strSQL];
//    if (!b) {
//        NSLog(@"%@", strSQL);
//    }
//    return b;
////    return false;
//}

- (BOOL)insertIntoTable:(NSString *)tName withParams:(NSDictionary *)params{
    __block NSString *strSQL = [NSString stringWithFormat:@"insert into %@ (", tName];
    __block NSString *strSQL1 = [NSString stringWithFormat:@" values ("];
    
    NSMutableArray *paramArr = [NSMutableArray array];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        strSQL = [strSQL stringByAppendingString:[NSString stringWithFormat:@"%@, ", (NSString *)key]];
        strSQL1 = [strSQL1 stringByAppendingString:[NSString stringWithFormat:@"?, "]];
        [paramArr addObject:(NSString *)obj];
    }];
    strSQL = [strSQL substringToIndex:strSQL.length-2];
    strSQL1 = [strSQL1 substringToIndex:strSQL1.length-2];
    
    strSQL = [strSQL stringByAppendingString:[NSString stringWithFormat:@") %@)", strSQL1]];
    //    NSLog(@"insert:>>%@", strSQL);
    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:paramArr];;
    //    return false;
}

@end
