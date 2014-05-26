//
//  ProjectScrollObject.m
//  ShowCasePro
//
//  Created by Mac on 14-2-26.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ProjectScrollObject.h"

@implementation ProjectScrollObject

-(id)initWithFrame:(CGRect)frame
andSelectedPosition:(float)selectedPos
          andDelay:(float)delay
 andTitleImageName:(NSString *)titleImageName
andDeatilImageName:(NSString *)imageName
{
    UIImage *titleImage = [UIImage imageNamed:titleImageName];
    UIImage *detailImage = [UIImage imageNamed:imageName];
    
    self = [super initWithFrame:frame andSelectedPosition:selectedPos andDelay:delay];
    
    //标题imageview
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width/2, titleImage.size.height/2)];
    titleImageView.image = titleImage;
    [self addSubview:titleImageView];
    
    //内容imageview
    UIImageView *detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, detailImage.size.width/2, detailImage.size.height/2)];
    detailImageView.image = detailImage;
    
    //内容scrollview
    UIScrollView *detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleImageView.frame.size.height + 10, detailImage.size.width/2, frame.size.height - (titleImageView.frame.size.height + 10))];
    detailView.backgroundColor = [UIColor clearColor];
    detailView.contentSize = CGSizeMake(detailView.frame.size.width, detailImageView.frame.size.height);
    detailView.showsHorizontalScrollIndicator = NO;
    detailView.showsVerticalScrollIndicator = NO;
    detailView.bounces = NO;
    
    [detailView addSubview:detailImageView];
    
    [self addSubview:detailView];
    
    return self;
}

@end
