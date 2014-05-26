//
//  DatabaseOption+Tvideo.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-13.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+Tvideo.h"

@implementation DatabaseOption (Tvideo)

- (Tvideo *)selectVideoByID:(NSString *)videoid
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tvideo where id=%@", videoid];
    NSArray *arr = [self selectVideosBySQL:strSQL];
    if (arr.count <= 0) {
        return nil;
    }
    return arr[0];
}

- (NSMutableArray *)selectVideoByBrandID:(NSString *)brandid andSuiteID:(NSString *)suiteid{
    NSString *strSQL = @"select * from tvideo where 1=1 ";
    if (brandid != nil) {
        strSQL = [strSQL stringByAppendingFormat:@" and tbrandname=%@", brandid];
    }
    if (suiteid != nil) {
        strSQL = [strSQL stringByAppendingFormat:@" and tsuitesname=%@", suiteid];
    }
    return [self selectVideosBySQL:strSQL];
}

- (NSMutableArray *)selectVideosBySQL:(NSString *)strSQL
{
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        Tvideo *video = [[Tvideo alloc] init];
        video.tvideoid = [rs stringForColumn:@"id"];
        video.vname = [rs stringForColumn:@"vname"];
        video.tbrandname = [rs stringForColumn:@"tbrandname"];
        video.tsuitesname = [rs stringForColumn:@"tsuitesname"];
        video.video1 = [rs stringForColumn:@"video1"];
        video.video2 = [rs stringForColumn:@"video2"];
        video.video3 = [rs stringForColumn:@"video3"];
        video.content = [rs stringForColumn:@"content"];
        video.update_time = [rs stringForColumn:@"update_time"];
        video.type = [rs stringForColumn:@"type"];
        [arr addObject:video];
    }
    return arr;
}

- (NSMutableArray *)selectVideosByIDs:(NSString *)ids
{
    NSArray *idss = [ids componentsSeparatedByString:@","];
    NSMutableArray *arr = [NSMutableArray array];
    [idss enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arr addObject:[self selectVideoByID:obj]];
    }];
    return arr;
}

@end
