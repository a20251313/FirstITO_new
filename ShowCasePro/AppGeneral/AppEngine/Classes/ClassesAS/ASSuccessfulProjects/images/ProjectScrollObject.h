//
//  ProjectScrollObject.h
//  ShowCasePro
//
//  Created by Mac on 14-2-26.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ProjectObjectDetail.h"

@interface ProjectScrollObject : ProjectObjectDetail

-(id)initWithFrame:(CGRect)frame
andSelectedPosition:(float)selectedPos
          andDelay:(float)delay
 andTitleImageName:(NSString *)titleImageName
andDeatilImageName:(NSString *)imageName;

@end
