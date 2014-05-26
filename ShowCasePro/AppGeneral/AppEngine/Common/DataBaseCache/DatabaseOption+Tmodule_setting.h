//
//  DatabaseOption+Tmodule_setting.h
//  ShowCasePro
//
//  Created by lvpw on 14-1-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tmodule_setting.h"

@interface DatabaseOption (Tmodule_setting)

- (Tmodule_setting *)selectByBrandid:(NSString *)branid andTypeid:(NSString *)typeID;

@end
