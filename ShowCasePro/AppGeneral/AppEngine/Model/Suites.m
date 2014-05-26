//
//  suites.m
//  ShowCasePro
//
//  Created by lvpw on 13-11-26.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "Suites.h"

@implementation Suites

- (void)setSuiteid:(NSString *)suiteid
{
    self.baseid = suiteid;
    _suiteid = suiteid;
}

- (void)setSuites_logo:(NSString *)suites_logo
{
    self.image = suites_logo;
    _suites_logo = suites_logo;
}

@end
