//
//  ProjectGroup.h
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-15.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectBackButton.h"
#import "ProjectImages.h"
#import "ProjectOthers.h"
#import "ProjectObjectMain.h"
#import "ProjectScrollObject.h"

@interface ProjectGroup : NSObject

- (void) addObject:(ProjectObject *)object;
- (void) removeObject:(ProjectObject *)object;

- (void) orginProjects;
- (void) selectedProjects;
- (void) hideProjects;

@end
