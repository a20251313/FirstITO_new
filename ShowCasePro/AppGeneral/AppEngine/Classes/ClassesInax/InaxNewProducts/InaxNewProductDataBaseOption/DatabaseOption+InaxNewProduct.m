//
//  DatabaseOption+InaxNewProduct.m
//  ShowCasePro
//
//  Created by Mac on 14-3-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption+InaxNewProduct.h"
#import "InaxNewProduct.h"

@implementation DatabaseOption (InaxNewProduct)

-(NSDictionary *)inaxNewProductDictionary
{
    NSString *sql = @"select * from t_inax_newproduct order by orderby";
    
    FMResultSet *set = [self.fmdb executeQuery:sql];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    while ([set next])
    {
        InaxNewProduct *inaxNewProduct = [InaxNewProduct new];
        
        inaxNewProduct.InaxNewProductID = [set stringForColumn:@"id"];
        inaxNewProduct.name             = [set stringForColumn:@"name"];
        inaxNewProduct.suiteid          = [set stringForColumn:@"suiteid"];
        inaxNewProduct.type_id          = [set stringForColumn:@"typeid"];
        inaxNewProduct.subtypeid        = [set stringForColumn:@"subtypeid"];
        inaxNewProduct.image            = [set stringForColumn:@"image"];
        inaxNewProduct.update_time      = [set stringForColumn:@"update_time"];
        inaxNewProduct.orderby          = [set stringForColumn:@"orderby"];
        inaxNewProduct.section          = [set stringForColumn:@"section"];
        
        [dataArray addObject:inaxNewProduct];
    }
    
    if (!dataArray.count) {
        return nil;
    }
    
    NSMutableArray *section0Array = [NSMutableArray array];
    NSMutableArray *section1Array = [NSMutableArray array];
    NSMutableArray *section2Array = [NSMutableArray array];
    
    for (InaxNewProduct *np in dataArray)
    {
        if ([np.section isEqualToString:@"0"])
        {
            [section0Array addObject:np];
        }
        else if ([np.section isEqualToString:@"1"])
        {
            [section1Array addObject:np];
        }
        else
        {
            [section2Array addObject:np];
        }
    }
    
    [dataArray removeAllObjects];
    dataArray = nil;
    
    if (!section0Array.count || !section1Array.count || !section2Array.count) {
        return nil;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[section0Array,section1Array,section2Array]
                                                     forKeys:@[Section_0,Section_1,Section_2]];
    return dic;
}

@end
