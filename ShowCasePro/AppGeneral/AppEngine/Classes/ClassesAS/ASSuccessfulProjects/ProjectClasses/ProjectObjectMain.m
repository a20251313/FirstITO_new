//
//  ProjectObjectMain.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectObjectMain.h"

@interface ProjectObjectMain()
{
    UIButton *button;
    
    BOOL isSelected;
}

@end


@implementation ProjectObjectMain

-(id)initWithPoint:(CGPoint)point
  selectedPosition:(float)selectedPos
      hidePosition:(float)hidePos
      andMoveDelay:(float)delay
      andImageName:(NSString *)imageName
    andButtonPoint:(CGPoint)buttonPoint
andButtonImageName:(NSString *)buttonImageName
    andButtonBlock:(ButtonBlock)block
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *buttonImage = [UIImage imageNamed:buttonImageName];
    
    CGRect frame = CGRectMake(point.x, point.y, image.size.width/2, image.size.height/2);
    CGRect buttonFrame = CGRectMake(buttonPoint.x, buttonPoint.y, buttonImage.size.width/2, buttonImage.size.height/2);
    
    self = [super initWithFrame:frame andMoveDelay:delay];
    
    self.selectedPosition = selectedPos;
    self.hidePosition     = hidePos;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = image;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonEvent)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [imageView addGestureRecognizer:tap];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = buttonFrame;
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    self.buttonBlock = block;
    
    isSelected = NO;
    
    return self;
}

- (void) buttonEvent
{
    if (self.buttonBlock && !isSelected)
    {
        self.buttonBlock();
    }
}

-(void)orgin
{
    [super orgin];
    
    isSelected = NO;
    
    button.hidden = NO;
    
    [UIView animateWithDuration:AnimationDuration animations:^
    {
        button.alpha = 1;
    }];
}

-(void)selected
{
    [super selected];
    
    isSelected = YES;
    
    [UIView animateWithDuration:AnimationDuration animations:^
     {
         button.alpha = 0;
         
     }completion:^(BOOL finished)
    {
         button.hidden = YES;
     }];
}

-(void)hide
{
    [super hide];
    
    isSelected = YES;
}





@end
