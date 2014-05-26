//
//  LixilWoodenproductSyleView.h
//  ShowCasePro
//
//  Created by Ran Jingfu on 5/25/14.
//  Copyright (c) 2014 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LixilWoodenproductSyleViewdelegate <NSObject>

-(void)clickWithProductCode:(NSString*)strCode;

@end

@interface LixilWoodenproductSyleView : UIView

@property(nonatomic,weak)id<LixilWoodenproductSyleViewdelegate> delegate;

-(IBAction)clickProduct:(UIButton*)sender;
@end
