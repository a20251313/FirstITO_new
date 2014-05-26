//
//  CoverButtonLixil.h
//  LixilHomePageDemo
//
//  Created by Mac on 14-2-22.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "CoverButton.h"

@interface CoverButtonLixil : UIView

+(id)ButtonWithBgImageNameArray:(NSArray *)bgImageNameArray
           buttonImageNameArray:(NSArray *)buttonImageNameArray
                 coverImageName:(NSString *)coverImageName
                   buttonBlock1:(ButtonBlock)block1
                   buttonBlock2:(ButtonBlock)block2
                   buttonBlock3:(ButtonBlock)block3
                      moveDelta:(CGPoint)delta
                       duration:(float)duration;

-(void)resetPosition;

- (void)fadeInWithDuration:(float)d;
- (void)fadeOutWithDuration:(float)d;

@end
