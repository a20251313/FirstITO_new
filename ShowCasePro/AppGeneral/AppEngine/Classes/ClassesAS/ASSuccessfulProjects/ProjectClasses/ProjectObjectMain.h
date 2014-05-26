//
//  ProjectObjectMain.h
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectObject.h"

typedef void(^ButtonBlock)(void);

@interface ProjectObjectMain : ProjectObject

@property (nonatomic , copy) ButtonBlock buttonBlock;

- (id) initWithPoint:(CGPoint)point
    selectedPosition:(float)selectedPos
        hidePosition:(float)hidePos
        andMoveDelay:(float)delay
        andImageName:(NSString *)imageName
      andButtonPoint:(CGPoint)buttonPoint
  andButtonImageName:(NSString *)buttonImageName
      andButtonBlock:(ButtonBlock)block;

@end
