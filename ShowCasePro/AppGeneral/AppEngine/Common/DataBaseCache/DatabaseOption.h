//
//  DatabaseOption.h
//  
//  数据库的读写操作
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#define ODB_DATABASE_SQLITE_VERSION 3
#define ODB_DATABASE_NAME @"showcasedb.db"
#define ODB_DATABASE_FULL_PATH [kDocuments stringByAppendingPathComponent:ODB_DATABASE_NAME]

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "FMDatabase.h"

@interface DatabaseOption : NSObject
{
    FMDatabase *_fmdb;
}

@property (nonatomic, retain) FMDatabase *fmdb;

/*打开数据库*/
- (BOOL)openDatabase;
/*关闭数据库*/
- (BOOL)closeDatabase;



@end
