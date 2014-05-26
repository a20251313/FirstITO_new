//
//  ObjectBase.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-10.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectBase : NSObject

@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSString *baseid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;

- (NSDictionary *)dictionary;

@end
