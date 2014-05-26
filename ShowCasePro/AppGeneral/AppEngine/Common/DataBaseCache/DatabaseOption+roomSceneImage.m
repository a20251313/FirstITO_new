//
//  DatabaseOption+roomSceneImage.m
//  ShowCasePro
//
//  Created by CY-003 on 13-12-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "DatabaseOption+roomSceneImage.h"

@implementation DatabaseOption (roomSceneImage)

- (NSString *)roomSceneImagePathWithProductID:(NSString *)productID
{
    NSString *path = @"";
    
    NSString *sql = [NSString stringWithFormat:@"select space1,space2,space3,space4 from suites where id in (select type2 from tproduct where id = '%@' and param31 = 1)",productID];
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    while ([set next]) {
        path = [self appendingString:path add:[set stringForColumnIndex:0]];
        path = [self appendingString:path add:[set stringForColumnIndex:1]];
        path = [self appendingString:path add:[set stringForColumnIndex:2]];
        path = [self appendingString:path add:[set stringForColumnIndex:3]];
    }
    
    if ([path isEqualToString:@""]) {
        return nil;
    }
    
    return path;
}

- (NSString *) appendingString:(NSString *)path add:(NSString *)temp
{
    if (!temp || [temp isEqualToString:@""]) {
        return path;
    }
    
    return [path stringByAppendingFormat:@"%@,",temp];
}

@end
