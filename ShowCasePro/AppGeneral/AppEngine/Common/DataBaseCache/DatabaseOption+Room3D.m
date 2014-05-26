//
//  DatabaseOption+Room3D.m
//  ShowCasePro
//
//  Created by dd on 14-4-29.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Room3D.h"
#import "NSObject+RuntimeMethods.h"

@implementation DatabaseOption (Room3D)

//根据套间id获取对应的3d房间
- (Room3D *) roomWithSuiteID:(NSString *)suiteID
{
    return (Room3D *)[[self assignObjectsWithSql:[NSString stringWithFormat:@"select * from t_3d_room where suite_id = %@ and status = 1",suiteID]
                              andObjectClassName:[Room3D class]]
                      firstObject];
}

//根据3d房间id获取此房间内所有可展示的类别
- (NSArray *) typesWithRoomID:(NSString *)roomID
{
    return [self assignObjectsWithSql:[NSString stringWithFormat:@"select * from t_3d_type where room_id = %@ and status = 1",roomID]
                    andObjectClassName:[Type3D class]];
}

//根据3d产品id获取该产品详情
- (Product3D *) product3DWithProductID:(NSString *)productID
{
    return (Product3D *)[[self assignObjectsWithTableName:@"t_3d_product"
                                                    andID:productID
                                       andObjectClassName:[Product3D class]]
                         firstObject];
}

//根据类别获取此类别所有产品信息
- (NSArray *) productsWithTypeID:(NSString *)typeID
{
    return [self assignObjectsWithTableName:@"t_3d_product"
                                      andID: ((Type3D *)[[self assignObjectsWithTableName:@"t_3d_type"
                                                                                    andID:typeID
                                                                       andObjectClassName:[Type3D class]] firstObject]).product_id
                         andObjectClassName:[Product3D class]];
}

/*
 *  传入 1.表名  2.对应id  3.类名 即可为对象进行自动赋值  返回对象数组
 *  表名示例    :  @"t_3d_product"
 *  id示例     :  @"1"  or  @"1,2,3"
 *  类名示例    :  [NSObject class]
 */

- (NSArray *) assignObjectsWithTableName:(NSString *)tableName andID:(NSString *)someID andObjectClassName:(Class) objectClass
{
    if (!tableName || !someID || !objectClass || !tableName.length || !someID.length)
    {
        NSLog(@"Error:%@:%@:数据有误.",[[self class] description],NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSArray *arrayID = [someID componentsSeparatedByString:@","];
    
    for (NSString *strID in arrayID)
    {
        if ([strID intValue] == 0)
        {
            NSLog(@"Error:%@:%@:ID有误.",[[self class] description],NSStringFromSelector(_cmd));
            return nil;
        }
    }
    
    NSArray *nameArray = [tableName componentsSeparatedByString:@"_"];
    NSString *fieldName = [nameArray lastObject];
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@_id in (%@) and status = 1",tableName,fieldName,someID];
    
    return [self assignObjectsWithSql:sql andObjectClassName:objectClass];
}


/*
 *  传入 1.sql语句  2.需要创建的对象的类   即可为对象进行自动赋值  返回对象数组
 *  sql 示例 :  @"select * from tproduct where param31 = 1"
 *  类名示例 :  [NSObject class]
 */

- (NSArray *) assignObjectsWithSql:(NSString *)sql andObjectClassName:(Class) objectClass
{
    NSArray *propertyList = [[objectClass new] propertyList];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    while ([set next])
    {
        NSObject *object = [objectClass new];
        
        BOOL addSomeValue = NO;
        
        for (NSString *propertyName in propertyList)
        {
            NSString *value = [set stringForColumn:propertyName];
            
            if (value)
            {
                [object setValue:value forKey:propertyName];
                
                addSomeValue = YES;
            }
        }
        
        //如果没有添加属性  则默认此对象无效  不添加
        if (addSomeValue)
        {
            [dataArray addObject:object];
        }
    }
    
    if (dataArray.count)
    {
        return dataArray;
    }
    
    return nil;
}

@end
