//
//  ProjectImages.h
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-18.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectObjectDetail.h"

@interface ProjectImages : ProjectObjectDetail

-(id)initWithFrame:(CGRect)rect
andSelectedPosition:(float)selectedPos
          andDelay:(float)delay
     andImagesName:(NSArray *)imagesName
    andImagesFrame:(NSArray *)imagesFrame;  //frame是CGRect对象转化的字符串

@end
