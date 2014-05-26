//
//  Store.h
//  MapDemo
//
//  Created by CY-004 on 13-11-14.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface Store : NSObject

@property (strong, nonatomic) NSString *stroreName;
@property (strong, nonatomic) NSString *storeAddress;
@property (strong, nonatomic) NSString *storePhone;
@property (strong, nonatomic) UIImage *storeImage;
@property (strong, nonatomic) MAPointAnnotation *storeAnnotation;

- (id)initWithStoreName:(NSString *)stroreName storeAddress:(NSString *)storeAddress storePhone:(NSString *)storePhone storeImage:(UIImage *)storeImage storeAnnotation:(MAPointAnnotation *)storeAnnotation;

@end
