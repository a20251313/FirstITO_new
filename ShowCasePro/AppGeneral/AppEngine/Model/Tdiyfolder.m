//
//  Tdiyfolder.m
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "Tdiyfolder.h"

@implementation Tdiyfolder

- (id)initWithfoldername:(NSString *)foldername userid:(NSString *)userid cretae_date:(NSString *)cretae_date update_time:(NSString *)update_time version:(NSString *)version
{
    self = [super init];
    if (self) {
        _foldername = foldername;
        _userid = userid;
        _cretae_date = cretae_date;
        _update_time = update_time;
        _version = version;
    }
    return self;
}

@end
