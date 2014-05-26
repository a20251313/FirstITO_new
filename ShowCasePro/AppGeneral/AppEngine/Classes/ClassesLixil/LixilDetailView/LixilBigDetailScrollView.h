//
//  LixilBigDetailScrollView.h
//  ShowCasePro
//
//  Created by Joshon on 14-5-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ScrollorientationTypeHorizontal,
    ScrollorientationTypeVertical
    
    
}ScrollorientationType;
@interface LixilBigDetailScrollView : UIImageView<UIScrollViewDelegate>

@property(nonatomic,strong)NSArray  *imageArray;
@property(nonatomic)NSInteger   page;
@property(nonatomic)CGRect      origiRect;
@property(nonatomic)ScrollorientationType  orientationType;
@property(nonatomic)BOOL        NeedDismiss;


@property(nonatomic,strong)NSArray  *arrayRBottomImage;


-(void)setShowBigImage:(UIImage*)image orientation:(ScrollorientationType)type;
-(void)setHorizontalImage:(UIImage*)image;
@end
