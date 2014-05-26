//
//  SSView.h
//  Paginator Example
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 Synthetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHorizontalView.h"
@class SHorizontalView;

@interface SSView : UIView{
    @public
    SHorizontalView* svHorizontal;
}

@property(nonatomic,retain)NSArray* dsOri;
@property(nonatomic,retain)NSIndexPath* curIndexPath;

//ds:array with array
+(id)createWithFrame:(CGRect)frame ds:(NSArray*)ds;
-(id)initWithFrame:(CGRect)frame ds:(NSArray*)ds;

- (void)reloadData;

@end
