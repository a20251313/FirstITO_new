//
//  BrandSpaceView.h
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandSpace.h"
#import "BrandSpaceButton.h"

@protocol BrandSpaceDelegate <NSObject>

-(void)btnMoreClickEvent:(BrandSpaceButton *)sender WithSuiteColor:(UIColor *)color;

-(void)turnTo3DModulePageWith:(id)obj;

@end


@interface BrandSpaceView : UIView
{
    BOOL alreadTouch;
    BOOL alreadTouchSuite;
    
    BOOL allowTouchAdd;
    
    
}

@property(nonatomic,strong) BrandSpace *spaceProperty;

@property(nonatomic,strong) BrandSpaceButton *currentSelBtn;

@property(nonatomic,strong) BrandSpaceButton *currentAddBtn;

@property(nonatomic,strong) UITapGestureRecognizer *tapReconizer;

@property(nonatomic,strong) id<BrandSpaceDelegate> delegate;

@property(nonatomic,strong) UIColor *suiteColor;



+(id)initWIthSpaceData:(id)spaceData;

@end
