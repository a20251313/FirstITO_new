//
//  ProjectBackButton.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectBackButton.h"

@interface ProjectBackButton()

@property (nonatomic , copy) ButtonBlock buttonBlock;

@end

@implementation ProjectBackButton

-(id)initWithPoint:(CGPoint)point
andSelectedPosition:(float)selectedPos
          andDelay:(float)delay
      andImageName:(NSString *)imageName
    andButtonBlock:(ButtonBlock)block
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGRect frame = CGRectMake(point.x, point.y, image.size.width/2, image.size.height/2);
    
    self = [super initWithFrame:frame andSelectedPosition:selectedPos andDelay:delay];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.bounds;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    self.buttonBlock = block;
    
    return self;
}

- (void) buttonEvent
{
    if (self.buttonBlock)
    {
        self.buttonBlock();
    }
}

@end
