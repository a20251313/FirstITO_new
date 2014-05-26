//
//  CoverButton.m
//  LixilHomePageDemo
//
//  Created by Mac on 14-2-22.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "CoverButton.h"

@interface CoverButton ()
{
    UIImageView *bgImageView;
    OBShapedButton *button;
    
    CGPoint moveDelta;
    float duration;
}

@property (nonatomic, assign) CGRect buttonFrame;

@property (nonatomic, copy) ButtonBlock block;

@end

@implementation CoverButton

+(id)ButtonwithPoint:(CGPoint)point
         bgImageName:(NSString *)bgImageName
     buttonImageName:(NSString *)buttonImageName
         buttonBlock:(ButtonBlock)block
           moveDelta:(CGPoint)delta
            duration:(float)duration
           superView:(UIView *)superView
{
    UIImage *bgImage = [UIImage imageNamed:bgImageName];
    UIImage *buttonImage = [UIImage imageNamed:buttonImageName];
    
    CGRect frame = CGRectMake(point.x, point.y, bgImage.size.width/2, bgImage.size.height/2);
    
    CoverButton *cb = [CoverButton new];
    
    //背景图片
    cb->bgImageView = [[UIImageView alloc] initWithFrame:frame];
    cb->bgImageView.image = bgImage;
    cb->bgImageView.userInteractionEnabled = NO;
    cb->bgImageView.alpha = 0;
    [superView addSubview:cb->bgImageView];
    //[superView sendSubviewToBack:cb->bgImageView];
    
    //移动距离
    cb->moveDelta = delta;
    //动画时间
    cb->duration = duration;
    
    //上层按钮
    cb->button = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    cb->button.frame = frame;
    cb->button.adjustsImageWhenHighlighted = NO;
    cb->button.alpha = 0;
    [cb->button setImage:buttonImage forState:UIControlStateNormal];
    [cb->button addTarget:cb action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:cb->button];
    [superView bringSubviewToFront:cb->button];
    
    //按钮事件
    cb.block = block;
    
    cb.buttonFrame = frame;
    return cb;
}

-(void)buttonAction
{
    //移动button位置
    [UIView animateWithDuration:duration animations:^
    {
        CGRect frame = button.frame;
        frame.origin.x += moveDelta.x;
        frame.origin.y += moveDelta.y;
        button.frame = frame;
    }
     completion:^(BOOL finished)
     {
         if (self.block)
         {
             self.block();
         }
     }];
}

- (void)fadeInWithDuration:(float)d
{
    [UIView animateWithDuration:d animations:^
    {
        bgImageView.alpha = 1;
        button.alpha = 1;
    }];
}

- (void)fadeOutWithDuration:(float)d
{
    [UIView animateWithDuration:d animations:^
     {
         bgImageView.alpha = 0;
         button.alpha = 0;
     }];
}

-(void)resetPosition
{
    //self->bgImageView.frame = frame;
    self->button.frame = self.buttonFrame;
}

-(void)removeFromSuperView
{
    [self->bgImageView  removeFromSuperview];
    [self->button       removeFromSuperview];
}

@end
