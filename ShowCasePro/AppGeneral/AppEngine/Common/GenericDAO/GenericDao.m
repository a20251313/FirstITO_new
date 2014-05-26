//
//  GenericDao.m
//  ObjcGenericDAODemo
//
//  Created by lvpw on 14-2-19.
//  Copyright (c) 2014年 lvpw. All rights reserved.
//

#import "GenericDao.h"
#import <objc/message.h>

@interface GenericDao ()

@property (nonatomic, strong) NSString *className;

@end

@implementation GenericDao

#pragma mark - CRUD

#pragma mark - 插入

/**
 * @brief 向数据库插入数据
 * @param object 要插入的对象
 * @return 是否插入成功
 */
- (BOOL)insertWithObject:(id)object
{
//    // 将表名小写
//    NSString *tableName = [_className lowercaseString];
//    // 使用反射自动获取传入的实体类中的属性
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(NSClassFromString(_className), &outCount);
//    // 动态拼写一个SQL语句
//    NSString *strSQL1 = [NSString stringWithFormat:@"insert into %@ (", tableName];
//    NSString *strSQL2 = [NSString stringWithFormat:@"values ("];
//    // 参数数组
//    NSMutableArray *params = [[NSMutableArray alloc] initWithCapacity:outCount-1];
//    // 使用for循环遍历实体类的属性
//    for (i = 1; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        
//        strSQL1 = [strSQL1 stringByAppendingFormat:@"%@, ", key];
//        strSQL2 = [strSQL2 stringByAppendingString:@"?, "];
//        
//        id value = [object valueForKey:key];
//        [params addObject:value];
//    }
//    strSQL1 = [strSQL1 substringToIndex:strSQL1.length - 2];
//    strSQL1 = [strSQL1 stringByAppendingString:@")"];
//    strSQL2 = [strSQL2 substringToIndex:strSQL2.length-2];
//    strSQL2 = [strSQL2 stringByAppendingString:@")"];
//    NSString *strSQL = [NSString stringWithFormat:@"%@ %@", strSQL1, strSQL2];
//    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:params];
    return [self insertWithObject:object options:nil];
}

/**
 * @brief 向数据库插入数据
 * @param object 要插入的对象
 * @param options 属性名与字段名对应关系
 * @return 是否插入成功
 */
- (BOOL)insertWithObject:(id)object options:(NSDictionary *)options
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // 使用反射自动获取传入的实体类中的属性
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(_className), &outCount);
    // 动态拼写一个SQL语句
    NSString *strSQL1 = [NSString stringWithFormat:@"insert into %@ (", tableName];
    NSString *strSQL2 = [NSString stringWithFormat:@"values ("];
    // 参数数组
    NSMutableArray *params = [[NSMutableArray alloc] initWithCapacity:outCount-1];
    // 使用for循环遍历实体类的属性
    // i==1 去除了主键
    for (i = 1; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *fieldName = [key copy];
        if ([[options allKeys] containsObject:key]) {
            fieldName = options[key];
        }
        strSQL1 = [strSQL1 stringByAppendingFormat:@"%@, ", fieldName];
        strSQL2 = [strSQL2 stringByAppendingString:@"?, "];
        
        id value = [object valueForKey:key];
        [params addObject:value];
    }
    strSQL1 = [strSQL1 substringToIndex:strSQL1.length - 2];
    strSQL1 = [strSQL1 stringByAppendingString:@")"];
    strSQL2 = [strSQL2 substringToIndex:strSQL2.length-2];
    strSQL2 = [strSQL2 stringByAppendingString:@")"];
    NSString *strSQL = [NSString stringWithFormat:@"%@ %@", strSQL1, strSQL2];
    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:params];
}

#pragma mark - 删除

/**
 * @brief 按条件删除
 * @param propertyName 属性名
 * @param value 值
 * @return 是否删除成功
 */
- (BOOL)deleteByProperty:(NSString *)propertyName withValue:(NSString *)value
{
    return [self deleteByProperty:propertyName withValue:value options:nil];
}

/**
 * @brief 按条件删除
 * @param propertyName 属性名
 * @param value 值
 * @param options 属性名和字段名对应关系
 * @return 是否删除成功
 */
- (BOOL)deleteByProperty:(NSString *)propertyName withValue:(NSString *)value options:(NSDictionary *)options
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    NSString *fieldName = [propertyName copy];
    if ([[options allKeys] containsObject:propertyName]) {
        fieldName = options[propertyName];
    }
    NSString *strSQL = [NSString stringWithFormat:@"delete from %@ where %@=%@", tableName, fieldName, value];
    return [self.fmdb executeUpdate:strSQL];
}

#pragma mark - 更新

- (BOOL)updateProperty:(NSString *)propertyName withValue:(NSString *)value byProperty:(NSString *)propertyName1 withValue:(NSString *)value1
{
    return [self updateProperty:propertyName withValue:value byProperty:propertyName1 withValue:value1 options:nil];
}

- (BOOL)updateProperty:(NSString *)propertyName withValue:(NSString *)value byProperty:(NSString *)propertyName1 withValue:(NSString *)value1 options:(NSDictionary *)options
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    NSString *strSQL = [NSString stringWithFormat:@"update %@ set %@=%@ where %@=%@", tableName, options[propertyName]==NULL?propertyName:options[propertyName], value, options[propertyName1]==NULL?propertyName1:options[propertyName1], value1];
    return [self.fmdb executeUpdate:strSQL];
}

- (BOOL)updateProperties:(NSDictionary *)propertiesAndValues byParams:(NSDictionary *)paramsAndValues
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    __block NSString *strSQL = [NSString stringWithFormat:@"update %@ set ", tableName];
    [propertiesAndValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        strSQL = [strSQL stringByAppendingFormat:@" %@=%@, ", key, obj];
    }];
    strSQL = [strSQL substringToIndex:strSQL.length-2];
    strSQL = [strSQL stringByAppendingString:@" where "];
    [paramsAndValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        strSQL = [strSQL stringByAppendingFormat:@" %@=%@ and ", key, obj];
    }];
    strSQL = [strSQL substringToIndex:strSQL.length-4];
//    NSLog(@"%@", strSQL);
//    return NO;
    return [self.fmdb executeUpdate:strSQL];
}

- (BOOL)updateProperties:(NSDictionary *)propertiesAndValues byParams:(NSDictionary *)paramsAndValues options:(NSDictionary *)options
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    __block NSString *strSQL = [NSString stringWithFormat:@"update %@ set ", tableName];
    [propertiesAndValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *fieldName = [key copy];
        if ([[options allKeys] containsObject:key]) {
            fieldName = options[fieldName];
            NSLog(@"%@", fieldName);
        }
        strSQL = [strSQL stringByAppendingFormat:@" %@=%@, ", fieldName, obj];
    }];
    strSQL = [strSQL substringToIndex:strSQL.length-2];
    strSQL = [strSQL stringByAppendingString:@" where "];
    [paramsAndValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *fieldName = [key copy];
        if ([[options allKeys] containsObject:key]) {
            fieldName = options[fieldName];
        }
        strSQL = [strSQL stringByAppendingFormat:@" %@=%@ and ", fieldName, obj];
    }];
    strSQL = [strSQL substringToIndex:strSQL.length-4];
    NSLog(@"%@", strSQL);
    //    return NO;
    return [self.fmdb executeUpdate:strSQL];
}

#pragma mark - 查询

/**
 * @brief 查询所有
 * @return 返回对象集合
 */
- (NSMutableArray *)selectAll
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    NSString *strSQL = [NSString stringWithFormat:@"select * from %@", tableName];
    return [self selectObjectsByStrSQL:strSQL options:nil];
}

/**
 * @brief 查询所有
 * @return 返回对象集合
 */
- (NSMutableArray *)selectAllByOptions:(NSDictionary *)options
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    NSString *strSQL = [NSString stringWithFormat:@"select * from %@", tableName];
    return [self selectObjectsByStrSQL:strSQL options:options];
}

/**
 * @brief 根据字段名查询结果集
 * @param propertyName 属性名
 * @param value 条件的值
 * @return 返回对象集合
 */
- (NSMutableArray *)selectObjectsBy:(NSString *)propertyName withValue:(NSString *)value
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    NSString *strSQL = [NSString stringWithFormat:@"select * from %@ where %@=%@", tableName, propertyName, value];
    return [self selectObjectsByStrSQL:strSQL options:nil];
}

/**
 * @brief 根据字段名查询结果集
 * @param propertyName 属性名
 * @param value 条件的值
 * @param options 属性名和字段名的对应关系
 * @return 返回对象集合
 */
- (NSMutableArray *)selectObjectsBy:(NSString *)propertyName withValue:(NSString *)value options:(NSDictionary *)options
{
    // 将表名小写
    NSString *tableName = [_className lowercaseString];
    // sql语句
    NSString *strSQL = [NSString stringWithFormat:@"select * from %@ where %@=%@", tableName, options[propertyName]==NULL?propertyName:options[propertyName], value];
    return [self selectObjectsByStrSQL:strSQL options:options];
}

#pragma mark - Util

/**
 * @brief 根据SQL语句查询
 * @param strSQL SQL语句
 * @param options 属性名与字段名对应关系
 * @return 返回查询的数据集
 */
- (NSMutableArray *)selectObjectsByStrSQL:(NSString *)strSQL options:(NSDictionary *)options
{
    // 使用反射自动获取传入的实体类中的属性
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(_className), &outCount);
    // 执行查询
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *result = [NSMutableArray array];
    while ([rs next]) {
        NSObject *object = [[NSClassFromString(_className) alloc] init];
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *fieldName = [key copy];
            if ([[options allKeys] containsObject:key]) {
                fieldName = options[key];
            }
            NSValue *value = [rs objectForColumnName:fieldName];
            if (![value isEqual:[NSNull null]]) {
                [object setValue:value forKey:key];
            }
        }
        [result addObject:object];
    }
    return result;
}

/**
 * @brief 根据SQL语句查询结果
 * @param strSQL SQL语句
 * @return 返回查询的数据集 对象数组
 */
//- (NSMutableArray *)selectObjectsByStrSQL:(NSString *)strSQL
//{
//    // 使用反射自动获取传入的实体类中的属性
//    unsigned int outCount;
//    objc_property_t *properties = class_copyPropertyList(NSClassFromString(_className), &outCount);
//    // 执行查询
//    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
//    NSMutableArray *result = [NSMutableArray array];
//    while ([rs next]) {
//        NSObject *object = [[NSClassFromString(_className) alloc] init];
//        for (int i = 0; i < outCount; i++) {
//            objc_property_t property = properties[i];
//            NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//            NSValue *value = [rs objectForColumnName:key];
//            if (![value isEqual:[NSNull null]]) {
//                [object setValue:value forKey:key];
//            }
//        }
//        [result addObject:object];
//    }
//    return result;
//}

#pragma mark - Life Cycle

// 获取实例
- (id)initWithClassName:(NSString *)className
{
    self = [super init];
    if (self) {
        self.fmdb = [FMDatabase databaseWithPath:ODB_DATABASE_FULL_PATH];
        if (![self.fmdb open]) {
            //    NSLog(@"Could not open db.");
            return self;
        }
        self.className = className;
        //开启缓存
        [self.fmdb setShouldCacheStatements:YES];
    }
    return self;
}

- (void)changeClassName:(NSString *)className
{
    _className = className;
}

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
        
        NSLog(@"#####%@", path);
        NSData * database = [NSData dataWithContentsOfFile:path];
        [database writeToFile:ODB_DATABASE_FULL_PATH atomically:YES];
    }
}

- (BOOL)closeDatabase
{
    if ([self.fmdb close]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)openDatabase
{
    if ([self.fmdb open]) {
        return YES;
    }else {
        return NO;
    }
}

- (void)dealloc
{
    [self closeDatabase];
}

@end
