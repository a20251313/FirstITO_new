//
//  CalculatorView.m
//  Calculator
//
//  Created by CY-003 on 13-11-18.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import "InaxCalculatorView.h"
#import "DatabaseOption+ComputeRecord.h"

#define PullAnimationDuration 0.25


#define number_0    10
#define number_1    11
#define number_2    12
#define number_3    13
#define number_4    14
#define number_5    15
#define number_6    16
#define number_7    17
#define number_8    18
#define number_9    19

#define opea_dian   30
#define opea_baifen 31
#define opea_jia    32
#define opea_jian   33
#define opea_cheng  34
#define opea_chu    35
#define opea_clean  36
#define opea_equal  37


@interface InaxCalculatorView ()<UIAlertViewDelegate>
{
    BOOL needCleanShowText;
    int operatorPressedCount;
    double temp;
    
    
    //视图左侧的view 用于查看计算记录
    __weak IBOutlet UIView *recordView;
    
}

@property(nonatomic,strong) DatabaseOption *dbo;

@property(nonatomic,assign) double previousNumber;
@property(nonatomic,assign) double latestNumber;

@property(nonatomic,strong) NSString *operatorSymbol;


@property(nonatomic,strong) NSString *previousOperator;

@property(nonatomic,assign) CGPoint recordViewOrigin;

//要记录的计算式
@property (nonatomic , copy) NSString *tempString;
@property (nonatomic , copy) NSString *recordString;

//从数据库取出所有历史记录
@property (nonatomic , strong) NSMutableArray *recordArray;

@end

@implementation InaxCalculatorView


- (NSString *) pressedSymbol:(int) tag
{
    NSString *symbol = @"";
    
    switch (tag) {
        case number_0:
        {
            symbol = @"0";
        }
            break;
        case number_1:
        {
            symbol = @"1";
        }
            break;
        case number_2:
        {
            symbol = @"2";
        }
            break;
        case number_3:
        {
            symbol = @"3";
        }
            break;
        case number_4:
        {
            symbol = @"4";
        }
            break;
        case number_5:
        {
            symbol = @"5";
        }
            break;
        case number_6:
        {
            symbol = @"6";
        }
            break;
        case number_7:
        {
            symbol = @"7";
        }
            break;
        case number_8:
        {
            symbol = @"8";
        }
            break;
        case number_9:
        {
            symbol = @"9";
        }
            break;
        case opea_dian:
        {
            symbol = @".";
        }
            break;
        case opea_baifen:
        {
            symbol = @"%";
        }
            break;
        case opea_jia:
        {
            symbol = @"+";
        }
            break;
        case opea_jian:
        {
            symbol = @"-";
        }
            break;
        case opea_cheng:
        {
            symbol = @"*";
        }
            break;
        case opea_chu:
        {
            symbol = @"/";
        }
            break;
        case opea_clean:
        {
            symbol = @"C";
        }
            break;
        case opea_equal:
        {
            symbol = @"=";
        }
            break;
            
        default:
            break;
    }
    
    return symbol;
}


- (IBAction)operaterPressed:(UIButton *)sender
{
    NSString *senderSymbol = [self pressedSymbol:sender.tag];
    
    if ([senderSymbol isEqualToString:@"C"])
    {
        [self clearData];
        return;
    }

    operatorPressedCount++;

    if (operatorPressedCount > 1)
    {
        //暂时不做记录
        self.recordString = @"";
        
        if ([self.previousOperator isEqualToString:@"="] && (![senderSymbol isEqualToString:@"="]))
        {
            self.latestNumber = [showLable.text doubleValue];
            self.operatorSymbol = senderSymbol;
            return;
        }
        
        if ((![senderSymbol isEqualToString:@"="]) && (![senderSymbol isEqualToString:self.operatorSymbol]))
        {
            operatorPressedCount = 0;
            self.latestNumber = [showLable.text doubleValue];
            needCleanShowText = YES;
            self.operatorSymbol = senderSymbol;
            return;
        }
        
        [self computeWithPrevious:self.latestNumber latest:temp];
        self.latestNumber = [showLable.text doubleValue];
        return;
    }

    self.previousNumber = self.latestNumber;
    self.latestNumber = [showLable.text doubleValue];
    temp = [showLable.text doubleValue];
    needCleanShowText = true;
    
    //开始记录
    self.tempString = showLable.text;
    
    if (self.operatorSymbol) {
        [self compute];
    }
    
    if ([senderSymbol isEqualToString:@"+"])
    {
        self.previousOperator = self.operatorSymbol;
        self.operatorSymbol = @"+";
    }
    else if ([senderSymbol isEqualToString:@"-"])
    {
        self.previousOperator = self.operatorSymbol;
        self.operatorSymbol = @"-";
    }
    else if ([senderSymbol isEqualToString:@"*"])
    {
        self.previousOperator = self.operatorSymbol;
        self.operatorSymbol = @"*";
    }
    else if ([senderSymbol isEqualToString:@"/"])
    {
        self.previousOperator = self.operatorSymbol;
        self.operatorSymbol = @"/";
    }
    else if ([senderSymbol isEqualToString:@"%"])
    {
        self.previousOperator = self.operatorSymbol;
        self.operatorSymbol = @"%";
    }
    else if ([senderSymbol isEqualToString:@"="])
    {
        self.previousOperator = @"=";
        //self.operatorSymbol = @"=";
    }
    
    
    //开始记录
    if ([self.recordString isEqualToString:@""])
    {
        if ([senderSymbol isEqualToString:@"="])
        {
            return;
        }
        
        self.recordString = self.tempString;
        self.recordString = [self.recordString stringByAppendingString:self.operatorSymbol];
        return;
    }
    else
    {
        self.recordString = [self.recordString stringByAppendingString:self.tempString];
    }

    if ([senderSymbol isEqualToString:@"="])
    {
        self.recordString = [self.recordString stringByAppendingString:@"="];
        self.recordString = [self.recordString stringByAppendingString:showLable.text];
        
        //存到本地数据库
        [self.dbo addNewRecord:self.recordString];
        [self resetHistoryRecord];
        self.recordString = @"";
    }
    else
    {
        self.recordString = [self.recordString stringByAppendingString:self.operatorSymbol];
    }
}


- (void) cutString
{
    while (1)
    {
        if ([[showLable.text substringWithRange:NSMakeRange(showLable.text.length-1,1)] isEqualToString:@"0"]) {
            showLable.text = [showLable.text substringWithRange:NSMakeRange(0, showLable.text.length-1)];
            
        }else
        {
            if ([[showLable.text substringWithRange:NSMakeRange(showLable.text.length-1,1)] isEqualToString:@"."]) {
                showLable.text = [showLable.text substringWithRange:NSMakeRange(0, showLable.text.length-1)];
            }
            break;
        }
    }
}

- (void) compute
{
    if (!self.operatorSymbol)
    {
        return;
    }
    
    if ([self.operatorSymbol isEqualToString:@"+"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(self.previousNumber + self.latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"-"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(self.previousNumber - self.latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"*"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(self.previousNumber * self.latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"/"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(self.previousNumber / self.latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"%"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(self.latestNumber * 0.01)];
    }
    
    self.latestNumber = [showLable.text doubleValue];
    
    [self cutString];
}

- (void) computeWithPrevious:(float)previousNumber latest:(float)latestNumber
{
    if (!self.operatorSymbol)
    {
        return;
    }
    
    if ([self.operatorSymbol isEqualToString:@"+"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(previousNumber + latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"-"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(previousNumber - latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"*"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(previousNumber * latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"/"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(previousNumber / latestNumber)];
    }
    else if([self.operatorSymbol isEqualToString:@"%"])
    {
        showLable.text = [NSString stringWithFormat:@"%f",(previousNumber * 0.01)];
    }
    
    [self cutString];
}

- (IBAction)numberPressed:(UIButton *)sender
{
    if (needCleanShowText)
    {
        showLable.text = @"";
        needCleanShowText = false;
    }
    
    NSString *senderSymbol = [self pressedSymbol:sender.tag];
    
    operatorPressedCount = 0;
    
    if ([showLable.text hasPrefix:@"0"] && [senderSymbol isEqualToString:@"0"] && ![showLable.text hasPrefix:@"0."])
    {
        return;
    }else if (([showLable.text rangeOfString:@"."].length > 0) && [senderSymbol isEqualToString:@"."])
    {
        return;
    }
    else if ([showLable.text hasPrefix:@"0"] && [senderSymbol isEqualToString:@"."])
    {
        showLable.text = @"0.";
        return;
    }else if ([showLable.text hasPrefix:@"0"] && ![showLable.text hasPrefix:@"0."])
    {
        showLable.text = senderSymbol;
        return;
    }else if([showLable.text isEqualToString:@""] && [senderSymbol isEqualToString:@"."])
    {
        showLable.text = @"0.";
        return;
    }
    
    showLable.text = [showLable.text stringByAppendingString:senderSymbol];
}

- (void) clearData
{
    self.previousNumber = 0;
    self.latestNumber   = 0;
    self.operatorSymbol = nil;
    showLable.text      = @"0";
    needCleanShowText   = false;
    operatorPressedCount = 0;
    self.previousOperator = nil;
    temp = 0;
    self.recordString = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self clearData];
    
    self.dbo = [[DatabaseOption alloc] init];
    
    self.recordArray = [self.dbo allRecord];
    [self resetHistoryRecord];
}


- (IBAction)cleanDatabase:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:@"确认删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [av show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.dbo cleanAllRecord];
        [self resetHistoryRecord];
    }
}

//重置计算历史记录
- (void) resetHistoryRecord
{
    //清除之前的记录
    for (UIView *view in recordView.subviews)
    {
        [view removeFromSuperview];
    }
    
    self.recordArray = [self.dbo allRecord];
    
    float cellHeight = 30;
    
    UIScrollView *recordScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, recordView.frame.size.width, recordView.frame.size.height)];
    recordScrollView.contentSize = CGSizeMake(recordView.frame.size.width, cellHeight*self.recordArray.count);
    [recordView addSubview:recordScrollView];
    
    for (int i = 0; i < self.recordArray.count; i++)
    {
        CGRect frame = CGRectMake(0, (self.recordArray.count-i)*cellHeight, recordView.frame.size.width, cellHeight);
        
        UILabel *lable = [self creatRecordLableWithFrame:frame string:[self.recordArray objectAtIndex:i]];
        [recordScrollView addSubview:lable];
    }
}

- (UILabel *) creatRecordLableWithFrame:(CGRect)frame string:(NSString *)string
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.text = string;
    lable.adjustsFontSizeToFitWidth = YES;
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor blueColor];
    lable.font = [UIFont boldSystemFontOfSize:18];
    lable.textAlignment = NSTextAlignmentRight;
    return lable;
}

@end
