//
//  Tsuite_space.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-12.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "Tsuite_space.h"

@implementation Tsuite_space

- (void)setTsuite_spaceid:(NSString *)tsuite_spaceid
{
    _tsuite_spaceid = tsuite_spaceid;
    self.baseid = tsuite_spaceid;
}

- (void)setImage_ico:(NSString *)image_ico
{
    _image_ico = image_ico;
    self.image = image_ico;
}

- (void)setSpace_name:(NSString *)space_name
{
    _space_name = space_name;
    self.name = space_name;
}

@end
