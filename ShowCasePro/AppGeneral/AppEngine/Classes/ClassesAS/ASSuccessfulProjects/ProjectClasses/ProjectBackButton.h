//
//  ProjectBackButton.h
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectObjectDetail.h"

typedef void(^ButtonBlock)(void);

@interface ProjectBackButton : ProjectObjectDetail

-(id)initWithPoint:(CGPoint)point
andSelectedPosition:(float)selectedPos
          andDelay:(float)delay
      andImageName:(NSString *)imageName
    andButtonBlock:(ButtonBlock)block;

@end
