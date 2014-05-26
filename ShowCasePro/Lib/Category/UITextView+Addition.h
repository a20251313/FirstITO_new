//
//  UITextView+Addition.h
//  ShowCasePro
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Addition)

- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

- (float) contentHeight;

@end
