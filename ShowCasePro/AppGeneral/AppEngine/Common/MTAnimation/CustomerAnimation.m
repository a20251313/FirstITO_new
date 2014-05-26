//
//  interface.m
//  MTAnimation
//
//  Created by LX on 14-1-20.
//  Copyright (c) 2014年 Mysterious Trousers. All rights reserved.
//

#import "CustomerAnimation.h"
#import "UIView+MTAnimation.h"

@implementation CustomerAnimation


// 定义宏
//_startFrame     = _logoImageView.frame;
//_timingFuction  = kMTEaseOutBack;
#define _duration  1
#define _exaggeration   1.7
#define _endY           50
#define _endX           50
#define _endScale       1
#define _endRotation    0
#define _endAlpha       1

+(void)playerAnimationWithObj:(UIImageView *)view withStateFrame:(CGRect)frame withPoint:(CGPoint)point
{
    
    CGRect r                        = view.frame;
    r.size                          = view.frame.size;
    view.frame            = r;
    
    view.layer.transform  = CATransform3DIdentity;
    view.alpha            = 1;
    
    [UIView mt_animateViews:@[view]
                   duration:_duration
             timingFunction:MTTimingFunctionEaseOutElastic
                    options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
                     view.mt_animationPerspective = -1.0 / 500.0;
                     CGRect r                               = view.frame;
                     r.origin.x                             = point.x;
                     r.origin.y                             = point.y;
                     view.frame                   = [self scaledRect:r withStartFram:view.frame];
                     view.alpha                   = _endAlpha;
                     CGFloat radians                        = mt_degreesToRadians(_endRotation);
                     view.layer.transform         = CATransform3DMakeRotation(radians, 0, 1, 0);
                 } completion:^{
                     NSLog(@"completed");
                    
                 }];
    
    
}

+ (CGRect)scaledRect:(CGRect)r withStartFram:(CGRect)frame
{
    CGFloat h       = frame.size.height;
    CGFloat w       = frame.size.width;
    CGFloat hh      = h * _endScale;
    CGFloat ww      = w * _endScale;
    r.size.height   = hh;
    r.size.width    = ww;
    r.origin.y      -= (hh - h) / 2.0;
    r.origin.x      -= (ww - w) / 2.0;
    return r;
}

@end
