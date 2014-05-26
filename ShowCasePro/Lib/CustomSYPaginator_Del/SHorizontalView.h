//
//  SHorizontalView.h
//  Paginator Example
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 Synthetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPaginator.h"

@class SVerticalView;

@interface SHorizontalView : UIView <SYPaginatorViewDataSource> {
    @public
    SYPaginatorView* myPV;
    SVerticalView* svVertical;
}

@property(nonatomic,retain) NSArray* ds;
@property(nonatomic,retain) NSIndexPath* curIndexPath;

@end
