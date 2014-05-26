//
//  ProjectObject.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-15.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectObject.h"

@interface ProjectObject()

@property (nonatomic , assign) float orginPosition;

@property (nonatomic , assign) float delay;

@end

@implementation ProjectObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        self.orginPosition = frame.origin.x;
        
        self.delay = 0;
        
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame andMoveDelay:(float)delay
{
    self = [self initWithFrame:frame];
    
    if (delay > AnimationDuration)
    {
        delay = AnimationDuration;
    }
    
    self.delay = delay;
    
    return self;
}

-(void) orgin
{
    [UIView animateWithDuration:AnimationDuration - self.delay
                          delay:self.delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^
    {
        [self resetFrame:self.orginPosition];
    }
                     completion:nil];
}

-(void) selected
{
    [UIView animateWithDuration:AnimationDuration - self.delay
                          delay:self.delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^
     {
         [self resetFrame:self.selectedPosition];
     }
                     completion:nil];
}

-(void) hide
{
    [UIView animateWithDuration:AnimationDuration - self.delay
                          delay:self.delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^
     {
         [self resetFrame:self.hidePosition];
     }
                     completion:nil];
}

-(void) resetFrame:(float)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

@end







