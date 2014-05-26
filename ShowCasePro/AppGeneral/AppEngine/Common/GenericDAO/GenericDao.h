//
//  GenericDao.h
//  ObjcGenericDAODemo
//
//  Created by lvpw on 14-2-19.
//  Copyright (c) 2014年 lvpw. All rights reserved.
//

#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define ODB_DATABASE_SQLITE_VERSION 3
#define ODB_DATABASE_NAME @"showcasedb.db"
#define ODB_DATABASE_FULL_PATH [kDocuments stringByAppendingPathComponent:ODB_DATABASE_NAME]

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>

@interface GenericDao : NSObject 

{
    FMDatabase *_fmdb;
}

@property (nonatomic, retain) FMDatabase *fmdb;

// 获取实例
- (id)initWithClassName:(NSString *)className;

// 可切换类名，适用于执行事务中，对多个不同对象操作
- (void)changeClassName:(NSString *)className;

/*打开数据库*/
- (BOOL)openDatabase;

/*关闭数据库*/
- (BOOL)closeDatabase;

/**
 * CRUD --- 规则
 * 1.options(NSDictionary类型):key为属性名，value为数据库字段名，一一对应
 * 2.value:字段如果是text类型，需要自行加''
 */

// 插入
- (BOOL)insertWithObject:(id)object;
- (BOOL)insertWithObject:(id)object options:(NSDictionary *)options;

// 删除
- (BOOL)deleteByProperty:(NSString *)propertyName withValue:(NSString *)value;
- (BOOL)deleteByProperty:(NSString *)propertyName withValue:(NSString *)value options:(NSDictionary *)options;

// 更新
- (BOOL)updateProperty:(NSString *)propertyName withValue:(NSString *)value byProperty:(NSString *)propertyName1 withValue:(NSString *)value1;
- (BOOL)updateProperty:(NSString *)propertyName withValue:(NSString *)value byProperty:(NSString *)propertyName1 withValue:(NSString *)value1 options:(NSDictionary *)options;
- (BOOL)updateProperties:(NSDictionary *)propertiesAndValues byParams:(NSDictionary *)paramsAndValues;
- (BOOL)updateProperties:(NSDictionary *)propertiesAndValues byParams:(NSDictionary *)paramsAndValues options:(NSDictionary *)options;

// 查询所有
- (NSMutableArray *)selectAll;
- (NSMutableArray *)selectAllByOptions:(NSDictionary *)options;

// 按条件查询 如果value是字符串请自行添加单引号('')
- (NSMutableArray *)selectObjectsBy:(NSString *)propertyName withValue:(NSString *)value;
- (NSMutableArray *)selectObjectsBy:(NSString *)propertyName withValue:(NSString *)value options:(NSDictionary *)options;

- (NSMutableArray *)selectObjectsByStrSQL:(NSString *)strSQL options:(NSDictionary *)options;

@end
