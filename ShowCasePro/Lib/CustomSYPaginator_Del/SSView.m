//
//  SSView.m
//  Paginator Example
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 Synthetic. All rights reserved.
//

#import "SSView.h"

@implementation SSView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(id)createWithFrame:(CGRect)frame ds:(NSArray*)ds{
    SSView* v =[[self alloc] initWithFrame:frame ds:ds];
    return v;
}

-(void)setCurIndexPath:(NSIndexPath *)aCurIndexPath{
    _curIndexPath = aCurIndexPath;
    
    svHorizontal.curIndexPath = self.curIndexPath;
}

-(id)initWithFrame:(CGRect)frame ds:(NSArray*)ds{
    self = [super initWithFrame:frame];
    if (self) {
        SHorizontalView* shv =[[SHorizontalView alloc] initWithFrame:frame];
        svHorizontal = shv;
        shv.ds = ds;
        [self addSubview:shv];
    }
    return self;
}

- (void)reloadData
{
    svHorizontal.ds = self.dsOri;
    [svHorizontal->myPV reloadData];
    [self setCurIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
