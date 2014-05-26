//
//  DatabaseOption+DIYFolder.m
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+DIYFolder.h"
#import "DatabaseOption+Tproduct.h"
#import "DatabaseOption+Synchronization.h"
#import <SBJson.h>

@implementation DatabaseOption (DIYFolder)

- (NSMutableArray *)selectAllFolders
{
    // 2014-03-07 修改sql语句，根据userid查找
    NSString *strSQL = [NSString stringWithFormat:@"select * from tdiyfolder where userid=%@ order by tdiyfolderid asc", [LibraryAPI sharedInstance].currentUser.userid];
    NSMutableArray *folders = [[NSMutableArray alloc] init];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    while (rs.next) {
        Tdiyfolder *folder = [[Tdiyfolder alloc] init];
        folder.tdiyfolderid = [rs stringForColumn:@"tdiyfolderid"];
        folder.foldername = [rs stringForColumn:@"foldername"];
        folder.userid = [rs stringForColumn:@"userid"];
        folder.cretae_date = [rs stringForColumn:@"cretae_date"];
        folder.update_time = [rs stringForColumn:@"update_time"];
        folder.version = [rs stringForColumn:@"version"];
        [folders addObject:folder];
    }
    return folders;
}

- (NSMutableArray *)selectAllFolderDetailsByFolderID:(NSString *)folderID
{
    NSString *strSQL = @"select * from tdiydetail where floderid = ? order by tdiydetailid desc";
    NSMutableArray *folderDetails = [[NSMutableArray alloc] init];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[folderID]];
    while (rs.next) {
        Tdiydetail *detail = [[Tdiydetail alloc] init];
        detail.floderid = [rs stringForColumn:@"floderid"];
        detail.tdiydetailid = [rs stringForColumn:@"tdiydetailid"];
        detail.productid = [rs stringForColumn:@"productid"];
        NSArray *arr = [self selectProductByProductID:detail.productid];
        if (arr.count!=0) {
            detail.product = arr[0];
        }else
        {
            continue;
        }
        detail.productname = [rs stringForColumn:@"productname"];
        detail.productimage = [rs stringForColumn:@"productimage"];
        detail.productcode = [rs stringForColumn:@"productcode"];
        detail.update_time = [rs stringForColumn:@"update_time"];
        detail.version = [rs stringForColumn:@"version"];
        [folderDetails addObject:detail];
    }
    return folderDetails;
}

- (BOOL)insertFolder:(Tdiyfolder *)diyfolder
{
    NSString *strSQL = @"insert into tdiyfolder (foldername, userid, cretae_date, update_time,version) values(?,?,?,?,?);";
    // 2014-03-07 修改sql语句，根据userid查找
    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:@[diyfolder.foldername, [LibraryAPI sharedInstance].currentUser.userid, [self nilToKongChuan:diyfolder.cretae_date], [self nilToKongChuan:diyfolder.update_time], [self nilToKongChuan:diyfolder.version]]];
}

- (BOOL)updateFolderName:(NSString *)folderName ByFolderID:(NSString *)folderid
{
    NSString *strSQL = @"update tdiyfolder set foldername=?, update_time=? where tdiyfolderid=?";
    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:@[folderName, [self currentTime], folderid]];
}

- (BOOL)deleteFolderByFolderID:(NSString *)folderid
{
    // 删除文件夹详细
    NSString *strSQL = @"delete from tdiydetail where floderid=?";
    if (![self.fmdb executeUpdate:strSQL withArgumentsInArray:@[folderid]]) {
        return NO;
    }
    strSQL = @"delete from tdiyfolder where tdiyfolderid=?";
    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:@[folderid]];
}

- (BOOL)insertFolderDetail:(Tproduct *)product folderID:(NSString *)folderid
{
    NSString *check = @"select * from tdiydetail where floderid=? and productid=?";
    FMResultSet *rs = [self.fmdb executeQuery:check withArgumentsInArray:@[folderid, product.productid]];
    if ([rs next]) {
        return NO;
    }
    NSString *strSQL = [NSString stringWithFormat:@"insert into tdiydetail (floderid, productid, productimage, productname, productcode) values('%@', '%@', '%@', '%@', '%@')", folderid, product.productid, product.image1, product.name, product.code];
    //    NSLog(@"%@", strSQL);
    return [self.fmdb executeUpdate:strSQL];;
}

- (Tdiyfolder *)selectTDIYFolderByFolderID:(NSString *)floderID
{
    NSString *strSQL = @"select * from tdiyfolder where tdiyfolderid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[floderID]];
    Tdiyfolder *folder = [[Tdiyfolder alloc] init];
    while ([rs next]) {
        folder.tdiyfolderid = [rs stringForColumn:@"tdiyfolderid"];
        folder.foldername = [rs stringForColumn:@"foldername"];
        folder.userid = [rs stringForColumn:@"userid"];
        folder.cretae_date = [rs stringForColumn:@"cretae_date"];
        folder.update_time = [rs stringForColumn:@"update_time"];
        folder.version = [rs stringForColumn:@"version"];
    }
    return folder;
}

- (NSString *)selectShareStringByFolderID:(NSString *)folderID
{
    Tdiyfolder *folder = [self selectTDIYFolderByFolderID:folderID];
    NSArray *arr = [self selectAllFolderDetailsByFolderID:folderID];
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[folder dictionary]];
    //    NSMutableArray *details = [NSMutableArray array];
    //    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        NSMutableDictionary *tempDetail = [[NSMutableDictionary alloc] initWithDictionary:[[arr objectAtIndex:idx] dictionary]];
    //        // 去除主键
    //        [tempDetail removeObjectForKey:@"tdiydetailid"];
    //        [details addObject:tempDetail];
    //    }];
    //    // 去除主键
    //    [dic removeObjectForKey:@"tdiyfolderid"];
    //    [dic setObject:details forKey:@"details"];
    //    NSString *result = [dic JSONRepresentation];
    __block NSString * result = [NSString stringWithFormat:@"%@%@",Dimensions_Per,folder.foldername];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = [result stringByAppendingFormat:@",%@", ((Tdiydetail *)obj).productid];
    }];
    return result;
}

- (BOOL)insertFolderByShareString:(NSString *)shareString
{
    if ([shareString hasPrefix:Dimensions_Per])
    {
        shareString = [shareString substringFromIndex:Dimensions_Per.length];
    }
    else
    {
        return false;
    }
    
    NSArray *arr = [shareString componentsSeparatedByString:@","];
    Tdiyfolder *folder = [[Tdiyfolder alloc] init];
    folder.foldername = arr[0];
    // 事务插入，错误回滚
    [self.fmdb beginTransaction];
    __block BOOL isRollBack = NO;
    @try {
        BOOL b = [self insertFolder:folder];
        if (b) {
            NSString *strSQL = @"select tdiyfolderid from tdiyfolder order by tdiyfolderid desc limit 1";
            FMResultSet *rs = [self.fmdb executeQuery:strSQL];
            NSString *folderid = nil;
            if ([rs next]) {
                folderid = [rs stringForColumnIndex:0];
            }
            [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (idx!=0) {
                    Tproduct *product = [[Tproduct alloc] init];
                    product.productid = obj;
                    if (![self insertFolderDetail:product folderID:folderid]) {
                        isRollBack = YES;
                    }
                }
            }];
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [self.fmdb rollback];
    }
    @finally {
        if (!isRollBack) {
            [self.fmdb commit];
        }
    }
    return !isRollBack;
    //    NSMutableDictionary *dic = [shareString JSONValue];
    //    NSArray *arr = [dic objectForKey:@"details"];
    //    [dic removeObjectForKey:@"details"];
    //    if ([self insertIntoTable:@"tdiyfolder" withParams:dic]) {
    //        NSString *strSQL = @"select tdiyfolderid from tdiyfolder order by tdiyfolderid desc limit 1";
    //        FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    //        // 取出生成的文件夹id
    //        NSString *folderid = nil;
    //        if ([rs next]) {
    //            folderid = [rs stringForColumnIndex:0];
    //        }
    //        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //            NSMutableDictionary *tempDetail = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)obj];
    //            // 替换
    //            [tempDetail setObject:folderid forKey:@"floderid"];
    //            [self insertIntoTable:@"tdiydetail" withParams:tempDetail];
    //        }];
    //        return YES;
    //    }
    //    return NO;
}

- (NSString *)nilToKongChuan:(NSString *)str
{
    return str!=nil?str:@"";
}


- (NSString *)currentTime
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * newDateOne = [dateformat stringFromDate:newDate];
    return newDateOne;
}

@end
