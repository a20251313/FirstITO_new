//
//  SashLeadingTechAnimationView.m
//  ShowCasePro
//
//  Created by CY-003 on 14-4-16.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashLeadingTechAnimationView.h"

@implementation SashLeadingTechAnimationView
{
    
    UIImageView *qihua;
    UIImageView *zhizao;
    UIImageView *shizuo;
    UIImageView *xiaoshou;
    UIImageView *guke;
    UIImageView *huan;
    
    UIImageView *bkg;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
       bkg =  [self addImageViewForView:@"sash_lt_des3" pointX:0 pointY:0];
        
        qihua = [self addImageViewForView:@"sash_lt_qihua_item" pointX:1024/2 pointY:180];
        
       huan  =  [self addImageViewForView:@"sash_lt_huan" pointX:295 pointY:180];
        
        
        
        
        
    }
    return self;
}
-(UIImageView *)addImageViewForView:(NSString *)imageName  pointX:(float)X pointY:(float)Y
{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(X, Y, img.size.width/2, img.size.height/2)];
    imgView.image = img;
    
    [self addSubview:imgView];
    return imgView;
    
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
