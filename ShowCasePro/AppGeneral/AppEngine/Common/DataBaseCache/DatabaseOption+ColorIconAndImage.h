//
//  DatabaseOption+ColorIconAndImage.h
//  ShowCasePro
//
//  Created by CY-003 on 14-1-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DatabaseOption.h"

#define COLOR_ICON  @"color_icon"
#define COLOR_IMAGE @"color_image"
#define COLOR_NAME @"color_name"


@interface DatabaseOption (ColorIconAndImage)

- (NSDictionary *) colorIconArrayAndImageArrayWithProductID:(NSString *)productID;

@end
