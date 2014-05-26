//
//  DatabaseOption.m
//  
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//


#import "DatabaseOption.h"

@implementation DatabaseOption

- (id)init
{
    if (self)
    {     
        self.fmdb = [FMDatabase databaseWithPath:ODB_DATABASE_FULL_PATH];
        if (![self.fmdb open]) {
        //    NSLog(@"Could not open db.");
            return self;
        }
        //开启缓存
        [self.fmdb setShouldCacheStatements:YES];
    }
    return self;
}

+ (void)initialize
{
    //将文件拷贝到应用程序沙箱中
    NSFileManager * fileMan = [NSFileManager defaultManager];
    if (![fileMan fileExistsAtPath:ODB_DATABASE_FULL_PATH]) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"showcasedb" ofType:@"db"];
        
//        debugLog(@"#####%@", path);
        NSData * database = [NSData dataWithContentsOfFile:path];
        [database writeToFile:ODB_DATABASE_FULL_PATH atomically:YES];
    }
//        NSString * path = [[NSBundle mainBundle] pathForResource:@"showcasedb" ofType:@"db"];
//        
//        //        debugLog(@"#####%@", path);
//        NSData * database = [NSData dataWithContentsOfFile:path];
//        [database writeToFile:ODB_DATABASE_FULL_PATH atomically:YES];
}

- (BOOL)closeDatabase
{
    if ([self.fmdb close]) {
        return YES;
    }else {
        return NO;
    }
    NSLog(@"close database");
}

- (BOOL)openDatabase
{
    if ([self.fmdb open]) {
        NSLog(@"open database");
        return YES;
    }else {
        return NO;
    }
}

- (void)dealloc
{
    [self closeDatabase];
}

/**
 判断数据库中表是否存在
 **/
- (BOOL) isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [self.fmdb executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        debugLog(@"%@ isOK %d", tableName,count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

@end
