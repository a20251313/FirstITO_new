//
//  CalculatorView.h
//  Calculator
//
//  Created by CY-003 on 13-11-18.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LixilCalculatorView : UIViewController
{
    
    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UILabel *showLable;
}


- (IBAction)numberPressed:(UIButton *)sender;


- (IBAction)operaterPressed:(UIButton *)sender;

@end
