//
//  DatabaseOption+ColorIconAndImage.m
//  ShowCasePro
//
//  Created by CY-003 on 14-1-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+ColorIconAndImage.h"

@implementation DatabaseOption (ColorIconAndImage)

-(NSDictionary *)colorIconArrayAndImageArrayWithProductID:(NSString *)productID
{
    NSString *sql = [NSString stringWithFormat:@"select a.id as id,b.image as colorico,a.image as product_image,b.name as color_name from tproduct_color_union a inner join tproduct_color b on a.colorid = b.id and a.productid = '%@'",productID];
    
    //NSLog(@"DatabaseOption+ColorIconAndImage : sql : %@",sql);

    NSMutableArray *iconArray  = [NSMutableArray array];
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *colorNameArray = [NSMutableArray array];
    
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    while ([set next])
    {
        NSString *iconPath  = [set stringForColumn:@"colorico"];
        NSString *imagePath = [set stringForColumn:@"product_image"];
        NSString *colorName = [set stringForColumn:@"color_name"];
        
        [iconArray  addObject:iconPath];
        [imageArray addObject:imagePath];
        [colorNameArray addObject:colorName];
    }
    
    if (!iconArray.count || !imageArray.count)
    {
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:iconArray forKey:COLOR_ICON];
    [dic setObject:imageArray forKey:COLOR_IMAGE];
    [dic setObject:colorNameArray forKey:COLOR_NAME];
    
    
    return dic;
}

@end
