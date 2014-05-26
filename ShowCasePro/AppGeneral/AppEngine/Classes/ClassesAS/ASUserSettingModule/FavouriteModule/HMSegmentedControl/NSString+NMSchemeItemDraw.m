//
//  NSString+NMSchemeItemDraw.m
//  HMSegmentedControlExample
//
//  Created by CY-004 on 13-11-18.
//  Copyright (c) 2013年 Hesham Abd-Elmegid. All rights reserved.
//

#import "NSString+NMSchemeItemDraw.h"

@implementation NSString (NMSchemeItemDraw)

-(void)  drawWithBasePoint:(CGPoint)basePoint
                  andAngle:(CGFloat)angle
                   andFont:(UIFont *)font{
    CGSize  textSize    =   [self   sizeWithFont:font];
    CGContextRef    context =   UIGraphicsGetCurrentContext();
    CGAffineTransform   t   =   CGAffineTransformMakeTranslation(basePoint.x, basePoint.y);
    CGAffineTransform   r   =   CGAffineTransformMakeRotation(angle);
    
    
    CGContextConcatCTM(context, t);
    CGContextConcatCTM(context, r);
    
    [self   drawAtPoint:CGPointMake(-1 * textSize.width / 2 + 8, -1 * textSize.height / 2 + 10)
               withFont:font];
    
    CGContextConcatCTM(context, CGAffineTransformInvert(r));
    CGContextConcatCTM(context, CGAffineTransformInvert(t));
}

@end
