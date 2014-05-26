//
//  ProjectObject.h
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-15.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AnimationDuration 1.5

@interface ProjectObject : UIView

@property (nonatomic , assign) float selectedPosition;
@property (nonatomic , assign) float hidePosition;

-(void) orgin;
-(void) selected;
-(void) hide;

- (id) initWithFrame:(CGRect)frame andMoveDelay:(float)delay;

@end
