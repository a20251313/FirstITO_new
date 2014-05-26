//
//  HMSegmentedControl.m
//  HMSegmentedControlExample
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "HMSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+NMSchemeItemDraw.h"

@interface HMSegmentedControl ()

@property (nonatomic, strong) CALayer *selectedSegmentLayer;
@property (nonatomic, strong) CALayer *segmentLayer;
@property (nonatomic, readwrite) CGFloat segmentWidth;

@end

@implementation HMSegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setDefaults];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.sectionTitles = sectiontitles;
        [self setDefaults];
    }
    
    return self;
}

- (void)setDefaults {
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.height = 32.0f;
    self.selectionIndicatorHeight = 5.0f;
    self.selectionIndicatorMode = HMSelectionIndicatorResizesToStringWidth;
    
    self.selectedSegmentLayer = [CALayer layer];
    self.segmentLayer = [CALayer layer];
}

#pragma mark - Drawing
//        [titleString drawWithBasePoint:CGPointMake((rect.origin.x + rect.size.width/2), (rect.origin.y+rect.size.height/2)) andAngle:M_PI_2*3 andFont:self.font];

- (void)drawRect:(CGRect)rect
{
    [self.backgroundColor set];
    UIRectFill([self bounds]);
    
    [self.textColor set];
    
    [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
        CGFloat stringHeight = [titleString sizeWithFont:self.font].height;
        CGFloat y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2);
        
        if (self.selectionIndicatorMode == HMSelectionIndicatorVertical) {
            CGRect rect = CGRectMake(self.height * idx, y, stringHeight, self.segmentWidth);
            if (idx == self.selectedIndex) {
                
                //根据品牌不同设置不同背景
                if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
                {
                    [[UIColor orangeColor] set];
                }
                else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
                {
                    [[UIColor colorWithRed:0/255. green:128/255. blue:220/255. alpha:1.] set];
                }
                else
                {
                    [[UIColor colorWithRed:184/255. green:156/255. blue:101/255. alpha:1.] set];
                }
                // 加粗
                [titleString drawWithBasePoint:CGPointMake((rect.origin.x + rect.size.width/2), (rect.origin.y+rect.size.height/2)) andAngle:M_PI_2*3 andFont:[UIFont systemFontOfSize:18]];
            } else {
                [self.textColor set];
                [titleString drawWithBasePoint:CGPointMake((rect.origin.x + rect.size.width/2), (rect.origin.y+rect.size.height/2)) andAngle:M_PI_2*3 andFont:self.font];
            }
        } else {
            CGRect rect = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, stringHeight);
            
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
            [titleString drawInRect:rect
                           withFont:self.font
                      lineBreakMode:UILineBreakModeClip
                          alignment:UITextAlignmentCenter];
            
#else
            [titleString drawInRect:rect
                           withFont:self.font
                      lineBreakMode:NSLineBreakByClipping
                          alignment:NSTextAlignmentCenter];
#endif
        }
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        CGRect frame = self.selectedSegmentLayer.frame;
        frame.size.width = self.frame.size.height;
        frame.size.height = 4;
        frame.origin = CGPointZero;
        self.segmentLayer.frame = frame;
        self.segmentLayer.backgroundColor = [UIColor colorWithRed:60/255. green:60/255. blue:60/255. alpha:1].CGColor;
        [self.layer addSublayer:self.segmentLayer];
        self.selectedSegmentLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
        [self.layer addSublayer:self.selectedSegmentLayer];
        
    }];
}

- (CGRect)frameForSelectionIndicator {
    CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedIndex] sizeWithFont:self.font].width;
    
    if (self.selectionIndicatorMode == HMSelectionIndicatorResizesToStringWidth) {
        CGFloat widthTillEndOfSelectedIndex = (self.segmentWidth * self.selectedIndex) + self.segmentWidth;
        CGFloat widthTillBeforeSelectedIndex = (self.segmentWidth * self.selectedIndex);
        
        CGFloat x = ((widthTillEndOfSelectedIndex - widthTillBeforeSelectedIndex) / 2) + (widthTillBeforeSelectedIndex - stringWidth / 2);
        return CGRectMake(x, 0.0, stringWidth, self.selectionIndicatorHeight);
    } else if(self.selectionIndicatorMode == HMSelectionIndicatorFillsSegment){
        return CGRectMake(self.segmentWidth * self.selectedIndex, 0.0, self.segmentWidth, self.selectionIndicatorHeight);
    } else {
//        NSLog(@"%d, %f", self.selectedIndex, self.height);
        return CGRectMake(self.height * self.selectedIndex, 0.0, self.height, self.selectionIndicatorHeight);
    }
}

- (void)updateSegmentsRects {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame)) {
        self.segmentWidth = 0;
        
        for (NSString *titleString in self.sectionTitles) {
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
        
        //        self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
        if (self.selectionIndicatorMode != HMSelectionIndicatorVertical)
            self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
        else {
            // 自动设置frame
            self.bounds = CGRectMake(0, 0, self.height * self.sectionTitles.count, self.segmentWidth);
        }
    } else {
        // 设置segment的宽和高
        if (self.selectionIndicatorMode != HMSelectionIndicatorVertical) {
            self.segmentWidth = self.frame.size.width / self.sectionTitles.count;
            self.height = self.frame.size.height;
        } else {
            self.segmentWidth = self.frame.size.height;
            self.height = self.frame.size.width / self.sectionTitles.count;
        }
        
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateSegmentsRects];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment;
        if (self.selectionIndicatorMode != HMSelectionIndicatorVertical) {
            segment = touchLocation.x / self.segmentWidth;
        } else {
            segment = touchLocation.x / self.height;
        }
        
        
        if (segment != self.selectedIndex) {
            [self setSelectedIndex:segment animated:YES];
        }
    }
}

#pragma mark -

- (void)setSelectedIndex:(NSInteger)index {
    [self setSelectedIndex:index animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {
    _selectedIndex = index;
    
    if (animated) {
        // Restore CALayer animations
        self.selectedSegmentLayer.actions = nil;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.15f];
        [CATransaction setCompletionBlock:^{
            if (self.superview)
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            if (self.indexChangeBlock)
                self.indexChangeBlock(index);
        }];
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        [CATransaction commit];
    } else {
        // Disable CALayer animations
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
        self.selectedSegmentLayer.actions = newActions;
        
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        
        if (self.superview)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        if (self.indexChangeBlock)
            self.indexChangeBlock(index);
        
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

@end
