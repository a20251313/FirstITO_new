//
//  ProjectGroup.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-15.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ProjectGroup.h"

@interface ProjectGroup()

@property (nonatomic , strong) NSMutableArray *projectsArray;

@end

@implementation ProjectGroup

- (void) addObject:(ProjectObject *)object
{
    if (object && ![self.projectsArray containsObject:object])
    {
        [self.projectsArray addObject:object];
    }
}

- (void) removeObject:(ProjectObject *)object
{
    if (object && [self.projectsArray containsObject:object])
    {
        [self.projectsArray removeObject:object];
    }
}

- (void) orginProjects
{
    for (ProjectObject *po in self.projectsArray)
    {
        [po orgin];
    }
}

-(void)selectedProjects
{
    for (ProjectObject *po in self.projectsArray)
    {
        [po selected];
    }
}

- (void) hideProjects
{
    for (ProjectObject *po in self.projectsArray)
    {
        [po hide];
    }
}

#pragma mark - init -

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.projectsArray = [NSMutableArray array];
    }
    
    return self;
}

@end

















