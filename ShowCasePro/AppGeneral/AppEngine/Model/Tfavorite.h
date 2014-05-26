//
//  Tfavorite.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-24.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "ObjectBase.h"

@interface Tfavorite : ObjectBase

@property (nonatomic, strong) NSString *tfavoriteid;
@property (nonatomic, strong) NSString *dateid;
@property (nonatomic, strong) NSString *yearmonth;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *update_date;
@property (nonatomic, strong) NSArray *details;

@end
