//
//  WoodenBrandConceptCell.m
//  ShowCasePro
//
//  Created by CY-003 on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "WoodenBrandConceptCell.h"

@implementation WoodenBrandConceptCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        self.imageView.opaque = true;
        self.imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.imageView];;
        self.blueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        self.blueImageView.opaque = true;
        self.blueImageView.backgroundColor = [UIColor clearColor];
        self.blueImageView.alpha = 0;
        [self.contentView addSubview:self.blueImageView];
        self.desImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 108, 82)];
        self.desImageView.center = CGPointMake(frame.size.width/2, 111);
        self.desImageView.opaque = true;
        self.desImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.desImageView];

    }
    return self;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.blueImageView.alpha = 0;
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
