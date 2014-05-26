//
//  UITextView+Addition.m
//  ShowCasePro
//
//  Created by lvpw on 13-12-16.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "UITextView+Addition.h"

@implementation UITextView (Addition)

- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    return fHeight;
}

-(float)contentHeight
{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(self.contentSize.width - fPadding, CGFLOAT_MAX);
    CGSize size = [self.text sizeWithFont: self.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 16.0;
    return fHeight;
}

@end
