//
//  ProjectOthers.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectOthers.h"

@implementation ProjectOthers

-(id)initWithPoint:(CGPoint)point
andSelectedPosition:(float)selectedPos
          andDelay:(float)delay
      andImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGRect frame = CGRectMake(point.x, point.y, image.size.width/2, image.size.height/2);
    
    self = [super initWithFrame:frame andSelectedPosition:selectedPos andDelay:delay];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = image;
    imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:imageView];
    
    return self;
}

@end
