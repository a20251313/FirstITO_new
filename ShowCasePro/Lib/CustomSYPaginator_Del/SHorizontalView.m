//
//  SHorizontalView.m
//  Paginator Example
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 Synthetic. All rights reserved.
//

#import "SHorizontalView.h"
#import "SVerticalView.h"

@implementation SHorizontalView 

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        myPV=[[SYPaginatorView alloc] initWithFrame:frame];
        myPV.dataSource = self;
        myPV.pageGapWidth = 20.f;
//        myPV.numberOfPagesToPreload = 1;
        myPV.pageControl.hidden = YES;
        [self addSubview:myPV];
    }
    return self;
}

#pragma mark - override

-(void)setDs:(NSArray *)aDS{
    if (_ds!=aDS) {
        _ds = [NSArray array];
        _ds =aDS;
    }
    [myPV reloadData];
    myPV.currentPageIndex = 0;
}

-(void)setCurIndexPath:(NSIndexPath *)aCurIndexPath{
    _curIndexPath = aCurIndexPath;
    
    myPV.currentPageIndex = aCurIndexPath.section;
    
    [self performSelector:@selector(delayOper) withObject:nil afterDelay:0.1];
    
}

-(void)delayOper{
    SVerticalView* svv = (SVerticalView*)[myPV pageForIndex:myPV.currentPageIndex];
    svv.curIndex = _curIndexPath.row;
}

#pragma mark - SYPaginatorViewDataSource

- (NSInteger)numberOfPagesForPaginatorView:(SYPaginatorView *)paginatorView{
    return self.ds.count;
}

- (SYPageView *)paginatorView:(SYPaginatorView *)paginatorView viewForPageAtIndex:(NSInteger)pageIndex{
    static NSString *identifier = @"HorizontalViewIdentifier";
	
	SVerticalView *view = (SVerticalView *)[paginatorView dequeueReusablePageWithIdentifier:identifier];
	if (!view) {
		view = [[SVerticalView alloc] initWithReuseIdentifier:identifier andFrame:paginatorView.frame];
	}
	
    NSArray* dsChild =[self.ds objectAtIndex:pageIndex];
    view.ds = dsChild;
	return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
