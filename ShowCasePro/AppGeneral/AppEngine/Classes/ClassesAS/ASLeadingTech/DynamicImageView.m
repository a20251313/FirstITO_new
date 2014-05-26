//
//  DynamicImageView.m
//  LeadingTechTest
//
//  Created by Mac on 14-2-21.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "DynamicImageView.h"

@interface DynamicImageView()
{
    UIImageView *topLight;
    UIImageView *bottomLight;
    
    
    CGRect topRect;
    CGRect bottomRect;
    
    UIImageView *currentImageView;
    UIView *imageViewBackgroundView;
}

@end



@implementation DynamicImageView

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, 122, 122);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImage *light = [UIImage imageNamed:@"lt_short_light"];
        
        topLight = [[UIImageView alloc] initWithFrame:CGRectMake(-130, 13, light.size.width/2, light.size.height/2)];
        topLight.image = light;
        [self addSubview:topLight];
        
        bottomLight = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 17, light.size.width/2, light.size.height/2)];
        bottomLight.image = light;
        [self addSubview:bottomLight];
        
        topRect = topLight.frame;
        bottomRect = bottomLight.frame;
        
        self.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
//        tap.numberOfTapsRequired = 1;
//        tap.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void) tapImage
{
    UIImage *image = self.image;
    
    CGRect frame = CGRectMake(self.superview.frame.origin.x + self.frame.origin.x, self.superview.frame.origin.y + self.frame.origin.y, image.size.width/2, image.size.height/2);
    
    imageViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    imageViewBackgroundView.backgroundColor = [UIColor blackColor];
    imageViewBackgroundView.alpha = 0;
    [self.superview.superview addSubview:imageViewBackgroundView];
    
    currentImageView = [[UIImageView alloc] initWithFrame:frame];
    currentImageView.image = image;
    currentImageView.userInteractionEnabled = NO;
    currentImageView.backgroundColor = [UIColor clearColor];
    [self.superview.superview addSubview:currentImageView];
    
    [UIView animateWithDuration:0.5 animations:^
     {
         imageViewBackgroundView.alpha = 0.4;
         
         currentImageView.frame = CGRectMake((1024-currentImageView.image.size.width/2)/2,
                                             (768-currentImageView.image.size.height/2)/2,
                                             currentImageView.image.size.width/2,
                                             currentImageView.image.size.height/2);
         
     } completion:^(BOOL finished)
     {
         UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(dismissImage)];
         swipe.direction = UISwipeGestureRecognizerDirectionUp;
         [imageViewBackgroundView addGestureRecognizer:swipe];
         
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(dismissImage)];
         tap.numberOfTouchesRequired = 1;
         tap.numberOfTapsRequired = 1;
         [imageViewBackgroundView addGestureRecognizer:tap];
         
    }];

}

-(void) dismissImage
{
    [UIView animateWithDuration:0.4 animations:^
     {
         imageViewBackgroundView.alpha = 0;
         
         CGRect rect = currentImageView.frame;
         
         rect.origin.y -= 700;
         
         currentImageView.frame = rect;
         
     } completion:^(BOOL finished)
     {
         [currentImageView removeFromSuperview];
         currentImageView = nil;
         
         [imageViewBackgroundView removeFromSuperview];
         imageViewBackgroundView = nil;
     }];
}

-(void)setImage:(UIImage *)image
{
    [super setImage:image];
    
    [self moveLight];
}

-(void) moveLight
{
    topLight.frame = topRect;
    bottomLight.frame = bottomRect;
    
    CGRect frame1 = topLight.frame;
    CGRect frame2 = bottomLight.frame;
    
    frame1.origin.x += 50;
    frame2.origin.x -= 50;
    
    [UIView animateWithDuration:1 animations:^
    {
        topLight.frame = frame1;
        bottomLight.frame = frame2;
    }];
}

@end
