//
//  ExpandedViewController.h
//  LearnAppaginaTableView
//
//  Created by CY-004 on 13-11-19.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tfavorite.h"
#import "TfavoriteDetail.h"

@class ExpandedViewController;

@protocol CommentChangeProtocol <NSObject>

- (void)expandedViewControllerCommentDidChange:(ExpandedViewController *)expandedViewController;

@end

@interface ExpandedViewController : UIViewController

@property (nonatomic, strong) Tfavorite *favorite;
@property (nonatomic, weak) id<CommentChangeProtocol> delegate;

@end
