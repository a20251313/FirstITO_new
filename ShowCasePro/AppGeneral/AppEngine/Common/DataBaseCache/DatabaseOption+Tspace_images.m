//
//  DatabaseOption+Tspace_images.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-12.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+Tspace_images.h"

@implementation DatabaseOption (Tspace_images)

- (NSMutableArray *)selectSpaceImageBySpaceID:(NSString *)spaceid
{
    NSString *strSQL = [NSString stringWithFormat:@"select * from tspace_images where space_id=%@", spaceid];
    FMResultSet *rs = [self.fmdb executeQuery:strSQL];
    NSMutableArray *arr = [NSMutableArray array];
    while ([rs next]) {
        Tspace_images *spaceImage = [[Tspace_images alloc] init];
        spaceImage.tspace_imagesid = [rs stringForColumn:@"id"];
        spaceImage.image_name = [rs stringForColumn:@"image_name"];
        spaceImage.image1 = [rs stringForColumn:@"image1"];
        spaceImage.image2 = [rs stringForColumn:@"image2"];
        spaceImage.image3 = [rs stringForColumn:@"image3"];
        spaceImage.image4 = [rs stringForColumn:@"image4"];
        spaceImage.space_id = [rs stringForColumn:@"space_id"];
        spaceImage.update_time = [rs stringForColumn:@"update_time"];
        [arr addObject:spaceImage];
    }
    return arr;
}

@end
