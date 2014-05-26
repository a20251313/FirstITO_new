//
//  SVerticalView.m
//  Paginator Example
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 Synthetic. All rights reserved.
//

#import "SVerticalView.h"
#import "PEPageView.h"
#import "Tmodulepages.h"
#import "LibraryAPI.h"

@implementation SVerticalView

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        myPV = [[SYPaginatorView alloc] initWithFrame:frame];
//        myPV.paginationDirection = SYPageViewPaginationDirectionVertical;
//        myPV.pageGapWidth = 20.f;
//        myPV.dataSource = self;
//        myPV.numberOfPagesToPreload = 1;
//        myPV.pageControl.hidden = YES;
//        [self addSubview:myPV];
    }
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = frame;
        myPV = [[SYPaginatorView alloc] initWithFrame:frame];
        myPV.dataSource = self;
        myPV.paginationDirection = SYPageViewPaginationDirectionVertical;
//        myPV.numberOfPagesToPreload = 1;
        myPV.pageControl.hidden = YES;
        [self addSubview:myPV];
    }
    return self;
}

#pragma mark - Init

-(void)setDs:(NSArray *)aDS{
    if (_ds!=aDS) {
        _ds = [NSArray array];
        _ds =aDS;
    }
    [myPV reloadData];
    myPV.currentPageIndex = 0;
}

-(void)setCurIndex:(int)aCurIndex{
    _curIndex = aCurIndex;
    [myPV reloadData];
    myPV.currentPageIndex = _curIndex;
}

#pragma mark - SYPaginatorViewDataSource

- (NSInteger) numberOfPagesForPaginatorView:(SYPaginatorView *)paginatorView{
    return self.ds.count;
}

- (SYPageView *)paginatorView:(SYPaginatorView *)paginatorView viewForPageAtIndex:(NSInteger)pageIndex{
    static NSString *identifier = @"VerticalViewIdentifier";
	
	PEPageView *view = (PEPageView *)[paginatorView dequeueReusablePageWithIdentifier:identifier];
	if (!view) {
		view = [[PEPageView alloc] initWithReuseIdentifier:identifier];
        view.backgroundColor = [UIColor colorWithRed:245./255 green:245./255 blue:245./255 alpha:1];
	}
    Tmodulepages *modulepage = [self.ds objectAtIndex:pageIndex];
    if ([self judgeStringIsNull:modulepage.bgimg]) {
        view.image = modulepage.bgimg;
    }
    if ([self judgeStringIsNull:modulepage.scrollerdesc]) {
        view.scrollerDescribeText = [NSString stringWithFormat:@"%@", modulepage.scrollerdesc];
    }
    if ([self judgeStringIsNull:modulepage.noscrollerdesc]) {
        view.notScrollerDescribeText = [NSString stringWithFormat:@"%@", modulepage.noscrollerdesc];
    }
    if ([self judgeStringIsNull:modulepage.scrollerimage]) {
        view.scrollerimage = modulepage.scrollerimage;
    }
    if ([self judgeStringIsNull:modulepage.horizontalbigimg]) {
        view.horizontalbigimg = modulepage.horizontalbigimg;
    }
    if ([self judgeStringIsNull:modulepage.verticalbigimg]) {
//        view.verticalbigimg
        view.verticalbigimg = modulepage.verticalbigimg;
    }
    if ([self judgeStringIsNull:modulepage.videoid]) {
        view.movieURL = modulepage.videoid;
    }
    if ([self judgeStringIsNull:modulepage.videosid]) {
        view.videos = modulepage.videos;
    }
    if ([self judgeStringIsNull:modulepage.pageid]) {
        if ([modulepage.pageid isEqualToString:@"1000"]) {
            view.pinpaichuancheng = @"ddd";
        } else if ([modulepage.pageid isEqualToString:@"1001"]) {
            view.shejilinggan = @"sf";
        } else if ([modulepage.pageid isEqualToString:@"1002"]) {
            view.gongchenganli = @"sf";
        }
    }
//    NSDictionary *dic = [self.ds objectAtIndex:pageIndex];
//    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSString *strKey = key;
//        if ([strKey isEqualToString:@"image"]) {
//            view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", obj]];
//        } else if ([strKey isEqualToString:@"ScrollerDescribe"]) {
//            view.scrollerDescribeText = [NSString stringWithFormat:@"%@", obj];
//        } else if ([strKey isEqualToString:@"video"]) {
//            view.movieURL = [NSString stringWithFormat:@"%@", obj];
//        } else if ([strKey isEqualToString:@"NotScrollerDescribe"]) {
//            view.notScrollerDescribeText = [NSString stringWithFormat:@"%@", obj];
//        } else if ([strKey isEqualToString:@"videos"]) {
//            view.videos = (NSArray *)obj;
//        }
//    }];
	
    if (self.ds.count > 1) {
        view.totalPages = [NSString stringWithFormat:@"%d", self.ds.count];
        view.currentPage = [NSString stringWithFormat:@"%d", pageIndex + 1];
        view.showCurrentPage = [NSString stringWithFormat:@"%d/%d", pageIndex+1, self.ds.count];
    }
	return view;
}

#pragma mark - Util

- (BOOL)judgeStringIsNull:(NSString *)string
{
    return (![string isEqualToString:@""] && ![string isEqual:[NSNull null]] && string!=nil);
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
