//
//  DatabaseOption+Tspace_images.h
//  ShowCasePro
//
//  Created by lvpw on 14-1-12.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"
#import "Tspace_images.h"

@interface DatabaseOption (Tspace_images)

- (NSMutableArray *)selectSpaceImageBySpaceID:(NSString *)spaceid;

@end
