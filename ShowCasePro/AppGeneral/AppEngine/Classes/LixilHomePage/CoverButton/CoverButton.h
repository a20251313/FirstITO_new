//
//  CoverButton.h
//  LixilHomePageDemo
//
//  Created by Mac on 14-2-22.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"

typedef void(^ButtonBlock)(void);

@interface CoverButton : NSObject

+ (id) ButtonwithPoint:(CGPoint)point
           bgImageName:(NSString *)bgImageName
       buttonImageName:(NSString *)buttonImageName
           buttonBlock:(ButtonBlock)block
             moveDelta:(CGPoint)delta
              duration:(float)duration
             superView:(UIView *)superView;

- (void)fadeInWithDuration:(float)d;
- (void)fadeOutWithDuration:(float)d;

- (void)resetPosition;

- (void)removeFromSuperView;

@end
