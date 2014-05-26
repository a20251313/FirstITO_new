//
//  ProjectObjectDetail.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectObjectDetail.h"

@implementation ProjectObjectDetail

-(id)initWithFrame:(CGRect)frame andSelectedPosition:(float)selectedPos andDelay:(float)delay
{
    self = [super initWithFrame:frame andMoveDelay:delay];
    
    self.selectedPosition = selectedPos;
    self.hidePosition = frame.origin.x;
    
    return self;
}

@end
