//
//  DatabaseOption+Tfavorite.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-24.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Tfavorite.h"
#import "Tfavorite.h"
#import "TfavoriteDetail.h"

@implementation DatabaseOption (Tfavorite)

- (NSArray *)monthsToSelect
{
    // 2014-03-07 修改sql语句，根据userid查找
    NSString *strSQL = [NSString stringWithFormat:@"select distinct(yearmonth) from tfavorite where userid=%@ order by id desc limit 10", [LibraryAPI sharedInstance].currentUser.userid];
    
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        NSString *str = [rs stringForColumnIndex:0];
        [array addObject:str];
    }
    return array;
}

- (int)addFavoriteProduct:(Tproduct *)product
{
    NSString *dateid = [self NSDateToStringByFormatter:@"yyyyMMdd"];
    
    // 检查是否存在当天的记录
    // 2014-03-07 修改sql语句，根据userid查找
    NSString *strSQL = @"select count(*) from tfavorite where dateid=? and userid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[dateid, [LibraryAPI sharedInstance].currentUser.userid]];
    if ([rs next]) {
        int i = [rs intForColumnIndex:0];
        if (i==0) {
            // 不存在 添加
            strSQL = @"insert into tfavorite (dateid, yearmonth, day, userid, update_date) values (?,?,?,?,?)";
            [self.fmdb executeUpdate:strSQL
                withArgumentsInArray:@[dateid,
                                       [self NSDateToStringByFormatter:@"MMyyyy"],
                                       [self NSDateToStringByFormatter:@"dd"],
                                       [LibraryAPI sharedInstance].currentUser.userid,
                                       [self NSDateToStringByFormatter:@"yyyy-MM-dd HH:mm:ss"]]];
        }
    }
    
    // 检查是否添加过
    strSQL = @"select count(*) from tfavoritedetail where id=? and productid=? and userid=?";
    FMResultSet *rs1 = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[dateid, product.productid, [LibraryAPI sharedInstance].currentUser.userid]];
    if ([rs1 next]) {
        NSInteger count = [rs1 intForColumnIndex:0];
        if (count==1) {
            return -1;
        }
    }
    
    // 执行添加操作
    strSQL = @"insert into tfavoritedetail (id, productid, productimg, update_date, userid) values (?,?,?,?,?)";
    int i = [self.fmdb executeUpdate:strSQL withArgumentsInArray:@[dateid, product.productid, product.image1, [self NSDateToStringByFormatter:@"yyyy-MM-dd HH:mm:ss"], [LibraryAPI sharedInstance].currentUser.userid]];
    return i;
}

- (NSArray *)selectFavoriteByYearMonth:(NSString *)yearmonth
{
    // 2014-03-07 修改sql语句，根据userid查找
    NSString *strSQL = @"select * from tfavorite where yearmonth=? and userid=? order by id desc";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[yearmonth, [LibraryAPI sharedInstance].currentUser.userid]];
    NSMutableArray *favorites = [NSMutableArray array];
    while ([rs next]) {
        Tfavorite *favorite = [[Tfavorite alloc]init];
        favorite.tfavoriteid = [rs stringForColumn:@"id"];
        favorite.dateid = [rs stringForColumn:@"dateid"];
        favorite.yearmonth = [rs stringForColumn:@"yearmonth"];
        favorite.day = [rs stringForColumn:@"day"];
        favorite.comment = [rs stringForColumn:@"comment"];
        favorite.userid = [rs stringForColumn:@"userid"];
        favorite.update_date = [rs stringForColumn:@"update_date"];
        favorite.details = [self selectFavoriteDetailsByDateID:favorite.dateid];
        [favorites addObject:favorite];
    }
    return favorites;
}

- (NSArray *)selectFavoriteDetailsByDateID:(NSString *)dateid
{
    NSString *strSQL = @"select * from tfavoritedetail where id=? and userid=?";
    FMResultSet *rs = [self.fmdb executeQuery:strSQL withArgumentsInArray:@[dateid, [LibraryAPI sharedInstance].currentUser.userid]];
    NSMutableArray *details = [NSMutableArray array];
    while ([rs next]) {
        TfavoriteDetail *detail = [[TfavoriteDetail alloc]init];
        detail.tfavoritedetailid = [rs stringForColumn:@"id"];
        detail.productid = [rs stringForColumn:@"productid"];
        detail.productimg = [rs stringForColumn:@"productimg"];
        detail.update_date = [rs stringForColumn:@"update_date"];
        detail.userid = [rs stringForColumn:@"userid"];
        [details addObject:detail];
    }
    return details;
}

- (int)deleteProductByDateID:(NSString *)dateid andProductid:(NSString *)productid
{
    NSString *strSQL = @"delete from tfavoritedetail where id=? and productid=?";
    return [self.fmdb executeUpdate:strSQL withArgumentsInArray:@[dateid, productid]];
}

- (BOOL)updateRemark:(NSString *)remark byTfavoriteID:(NSString *)tfavoriteid;
{
    NSString *strSQL = [NSString stringWithFormat:@"update tfavorite set comment='%@' where id=%@", remark, tfavoriteid];
    return [self.fmdb executeUpdate:strSQL];
}

#pragma mark - Util

- (NSString *)NSDateToStringByFormatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = formatterString;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
