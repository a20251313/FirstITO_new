//
//  Store.m
//  MapDemo
//
//  Created by CY-004 on 13-11-14.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import "Store.h"

@implementation Store

- (id)initWithStoreName:(NSString *)stroreName storeAddress:(NSString *)storeAddress storePhone:(NSString *)storePhone storeImage:(UIImage *)storeImage storeAnnotation:(MAPointAnnotation *)storeAnnotation
{
    self = [super init];
    if (self) {
        _stroreName = stroreName;
        _storeAddress = storeAddress;
        _storePhone = storePhone;
        _storeImage = storeImage;
        _storeAnnotation = storeAnnotation;
    }
    return self;
}

@end
