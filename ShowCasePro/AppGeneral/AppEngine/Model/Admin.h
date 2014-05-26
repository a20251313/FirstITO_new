//
//  Admin.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"

@interface Admin : ObjectBase

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *purview;
@property (nonatomic, strong) NSString *is_admin;
@property (nonatomic, strong) NSString *lastip;
@property (nonatomic, strong) NSString *lastlogin;

@end
