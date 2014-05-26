//
//  ProjectImages.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectImages.h"

#define FullScreenDuration  0.5
#define DismissDuration     0.4

@interface ProjectImages()
{
    NSArray *imageNameArray;
    NSArray *imageFrameArray;
    
    UIImageView *currentImageView;
    UIView *imageViewBackgroundView;
}

@property (nonatomic , strong) NSMutableArray *imageViewsArray;
@property (nonatomic , strong) NSMutableArray *retinaImageNameArray;

@end


@implementation ProjectImages

-(id)initWithFrame:(CGRect)rect andSelectedPosition:(float)selectedPos andDelay:(float)delay andImagesName:(NSArray *)imagesName andImagesFrame:(NSArray *)imagesFrame
{
    self = [super initWithFrame:rect andSelectedPosition:selectedPos andDelay:delay];
    
    imageNameArray  = imagesName;
    imageFrameArray = imagesFrame;
    
    [self creatImageViews];
    
    return self;
}

-(void)creatImageViews
{
    self.imageViewsArray        = [NSMutableArray array];
    self.retinaImageNameArray   = [NSMutableArray array];
    
    for (NSString *imageName in imageNameArray)
    {
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (!image)
        {
            continue;
        }
        
        CGRect frame = CGRectFromString([imageFrameArray objectAtIndex:[imageNameArray indexOfObject:imageName]]);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
        
        [self.imageViewsArray       addObject:imageView];
        [self.retinaImageNameArray  addObject:[imageName stringByAppendingString:@"-retina"]];
    }
}

-(void)tapImage:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    CGRect orginRect = imageView.frame;
    
    orginRect.origin.x += self.frame.origin.x;
    orginRect.origin.y += self.frame.origin.y;
    
    imageViewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    imageViewBackgroundView.backgroundColor = [UIColor blackColor];
    imageViewBackgroundView.alpha = 0;
    [self.superview.superview addSubview:imageViewBackgroundView];
    
    NSString *retinaImageName = [self.retinaImageNameArray objectAtIndex:[self.imageViewsArray indexOfObject:imageView]];
    
    currentImageView = [[UIImageView alloc] initWithFrame:orginRect];
    currentImageView.image = [UIImage imageNamed:retinaImageName];
    currentImageView.userInteractionEnabled = NO;
    currentImageView.backgroundColor = [UIColor clearColor];
    [self.superview.superview addSubview:currentImageView];
    
    [UIView animateWithDuration:FullScreenDuration animations:^
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
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(dismissImage)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [imageViewBackgroundView addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(dismissImage)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [imageViewBackgroundView addGestureRecognizer:swipeRight];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(dismissImage)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [imageViewBackgroundView addGestureRecognizer:tap];
        
//        UIImage *upImage = [UIImage imageNamed:@"sp_up"];
//        UIImageView *upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, upImage.size.width/2, upImage.size.height/2)];
//        upImageView.image = upImage;
//        upImageView.backgroundColor = [UIColor clearColor];
//        upImageView.userInteractionEnabled = YES;
//        upImageView.center = CGPointMake(currentImageView.frame.size.width/2, 40);
//        [currentImageView addSubview:upImageView];
    }];
    
}

-(void)dismissImage
{
    [UIView animateWithDuration:DismissDuration animations:^
    {
        imageViewBackgroundView.alpha = 0;
        
        currentImageView.alpha = 0;
        
//        CGRect rect = currentImageView.frame;
//        
//        rect.origin.y -= 700;
//        
//        currentImageView.frame = rect;
        
    } completion:^(BOOL finished)
    {
        [currentImageView removeFromSuperview];
        currentImageView = nil;
        
        [imageViewBackgroundView removeFromSuperview];
        imageViewBackgroundView = nil;
    }];
}

@end








