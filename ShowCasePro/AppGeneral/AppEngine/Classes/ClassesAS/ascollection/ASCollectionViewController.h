//
//  ASCollectionViewController.h
//  TCollectionViewController
//
//  Created by lvpw on 14-2-15.
//  Copyright (c) 2014年 lvpw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "BaseViewController.h"

@interface ASCollectionViewController : BaseViewController
@property (strong, nonatomic) IBOutlet iCarousel *iCarousel;
@property (strong, nonatomic) IBOutlet UIImageView *textImage;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *coverflowBtn;
@property (weak, nonatomic) IBOutlet UIButton *gridframeBtn;

- (IBAction)changeToGridFrameAction:(id)sender;
- (IBAction)changeToCoverFlowAction:(id)sender;

@end
