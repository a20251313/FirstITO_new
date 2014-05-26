//
//  SVerticalView.h
//  Paginator Example
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 Synthetic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPaginator.h"

@interface SVerticalView : SYPageView <SYPaginatorViewDataSource>{
    SYPaginatorView *myPV;
}

@property (nonatomic) int curIndex;

@property (nonatomic, strong) NSArray* ds;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;

@end
