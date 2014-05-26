//
//  CoverButtonLixil.m
//  LixilHomePageDemo
//
//  Created by Mac on 14-2-22.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "CoverButtonLixil.h"

@interface CoverButtonLixil()
{
    CoverButton *button1;
    CoverButton *button2;
    CoverButton *button3;
    
    OBShapedButton *coverButton;
    
    CGPoint moveDelta;
    float duration;
}

@end

@implementation CoverButtonLixil

+(id)ButtonWithBgImageNameArray:(NSArray *)bgImageNameArray
           buttonImageNameArray:(NSArray *)buttonImageNameArray
                 coverImageName:(NSString *)coverImageName
                   buttonBlock1:(ButtonBlock)block1
                   buttonBlock2:(ButtonBlock)block2
                   buttonBlock3:(ButtonBlock)block3
                      moveDelta:(CGPoint)delta
                       duration:(float)duration
{
    UIImage *coverImage = [UIImage imageNamed:coverImageName];
    
    
    CoverButtonLixil *cbl = [[CoverButtonLixil alloc] initWithFrame:CGRectMake(0, 0, coverImage.size.width/2, coverImage.size.height/2)];
    
    cbl->button1 = [CoverButton ButtonwithPoint:CGPointMake(0, 0)
                                    bgImageName:[bgImageNameArray objectAtIndex:0]
                                buttonImageName:[buttonImageNameArray objectAtIndex:0]
                                    buttonBlock:block1
                                      moveDelta:delta
                                       duration:duration
                                      superView:cbl];
    
    cbl->button2 = [CoverButton ButtonwithPoint:CGPointMake(0, 262.5)
                                    bgImageName:[bgImageNameArray objectAtIndex:1]
                                buttonImageName:[buttonImageNameArray objectAtIndex:1]
                                    buttonBlock:block2
                                      moveDelta:delta
                                       duration:duration
                                      superView:cbl];
    
    cbl->button3 = [CoverButton ButtonwithPoint:CGPointMake(0, 515.5)
                                    bgImageName:[bgImageNameArray objectAtIndex:2]
                                buttonImageName:[buttonImageNameArray objectAtIndex:2]
                                    buttonBlock:block3
                                      moveDelta:delta
                                       duration:duration
                                      superView:cbl];
    
    cbl->coverButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    cbl->coverButton.frame = cbl.frame;
    cbl->coverButton.adjustsImageWhenHighlighted = NO;
    [cbl->coverButton setImage:coverImage forState:UIControlStateNormal];
    [cbl->coverButton addTarget:cbl action:@selector(coverTouched) forControlEvents:UIControlEventTouchUpInside];
    [cbl addSubview:cbl->coverButton];
    
    cbl->moveDelta = delta;
    cbl->duration = duration;
    
    return cbl;
}

-(void)coverTouched
{
    CGRect frame = coverButton.frame;
    frame.origin.x += moveDelta.x;
    frame.origin.y += moveDelta.y;
    
    [UIView animateWithDuration:duration animations:^
    {
        coverButton.frame = frame;
    }];
}

-(void)resetPosition
{
    CGRect frame = coverButton.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    coverButton.frame = frame;
    
    [button1 resetPosition];
    [button2 resetPosition];
    [button3 resetPosition];
}

- (void)fadeInWithDuration:(float)d
{
    [button1 fadeInWithDuration:d];
    [button2 fadeInWithDuration:d];
    [button3 fadeInWithDuration:d];
}

- (void)fadeOutWithDuration:(float)d
{
    [button1 fadeOutWithDuration:d];
    [button2 fadeOutWithDuration:d];
    [button3 fadeOutWithDuration:d];
}

@end
