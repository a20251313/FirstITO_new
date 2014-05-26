//
//  Tdiyfolder.h
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"

@interface Tdiyfolder : ObjectBase

@property (nonatomic, strong) NSString *tdiyfolderid;
@property (nonatomic, strong) NSString *foldername;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *cretae_date;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *version;

- (id)initWithfoldername:(NSString *)foldername userid:(NSString *)userid cretae_date:(NSString *)cretae_date update_time:(NSString *)update_time version:(NSString *)version;

@end
