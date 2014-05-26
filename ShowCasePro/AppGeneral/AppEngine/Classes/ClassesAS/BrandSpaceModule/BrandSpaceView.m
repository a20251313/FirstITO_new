//
//  BrandSpaceView.m
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "BrandSpaceView.h"
#import "ModuleProduct.h"
#import "BrandSpace.h"

#import "DatabaseOption+BrandSpace.h"
#import "DatabaseOption+ModuleProduct.h"
#import "GenericDao+Suites.h"

#import "AppConfig.h"
#import "MacroDefine.h"


#define ICON_BG_FLASH_DURATION 1.5

@interface BrandSpaceView()

@property (nonatomic , strong) NSTimer *icoBgLightFlashTimer;

@property (nonatomic , strong) UIImageView *bgDesigner;
@property (nonatomic , strong) UIImageView *bg3dRoom;

@end

@implementation BrandSpaceView

const int TAG_DESIGNER = 100;
const int TAG_SUITE_DES = 55;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, 1024, 704);
        alreadTouch = NO;
        alreadTouchSuite = NO;
        allowTouchAdd = YES;
    }
    return self;
}

- (void) flashBgLight
{
    [UIView animateWithDuration:ICON_BG_FLASH_DURATION*0.45 animations:^
     {
         self.bgDesigner.alpha = 0;
         self.bg3dRoom.alpha = 0;
         
     } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:ICON_BG_FLASH_DURATION*0.45 animations:^
          {
              self.bgDesigner.alpha = 1;
              self.bg3dRoom.alpha = 1;
              
          } completion:nil];
     }];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


- (void) beginFlashLight
{
    self.icoBgLightFlashTimer = [NSTimer scheduledTimerWithTimeInterval:ICON_BG_FLASH_DURATION
                                                                 target:self
                                                               selector:@selector(flashBgLight)
                                                               userInfo:nil
                                                                repeats:YES];
    [self.icoBgLightFlashTimer fire];
}

- (void) stopFlashLight
{
    [self.icoBgLightFlashTimer invalidate];
    self.icoBgLightFlashTimer = nil;
    
    self.bgDesigner.alpha = 0;
    self.bg3dRoom.alpha = 0;
}

+(id)initWIthSpaceData:(id)spaceData
{
    BrandSpaceView *view = [[BrandSpaceView alloc] init];
    
    //初始化timer 用于icon下的闪烁
    [view beginFlashLight];
    
    BrandSpace *spaceProperty = (BrandSpace *)spaceData;
    view.spaceProperty = spaceProperty;
    
    // 获取当前空间的色调
    
    NSArray *colorList = [spaceProperty.suite_colore componentsSeparatedByString:@","];
    if (colorList.count == 3)
    {
        CGFloat colorR  = [[colorList objectAtIndex:0] floatValue];
        CGFloat colorG  = [[colorList objectAtIndex:1] floatValue];
        CGFloat colorB  = [[colorList objectAtIndex:2] floatValue];
        
        
        view.suiteColor = [UIColor colorWithRed:colorR / 255.0 green:colorG / 255.0 blue:colorB / 255.0 alpha:1];
    }
    
    // 1.根据品牌ID 查询所属空间
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    
    NSMutableArray *spaceProduct = [dbo getSpaceProductBySpaceID:spaceProperty.spaceID] ;
    
    // 2.加载空间图做背景
    NSString *path = [NSString stringWithFormat:@"%@/%@",kLibrary,spaceProperty.space_image];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    [bgView setFrame:CGRectMake(0, 0, 1024, 704)];
    
    [view addSubview:bgView];
    
    //2.2 左上角显示
    NSString *suiteIco_Paht = [NSString stringWithFormat:@"%@/%@",kLibrary,spaceProperty.suite_ico];
    NSString *suiteDes_Paht = [NSString stringWithFormat:@"%@/%@",kLibrary,spaceProperty.suite_des];
    
    UIImage *imageSuite_ico = [UIImage imageWithContentsOfFile:suiteIco_Paht];
    UIImage *imageSuite_Des = [UIImage imageWithContentsOfFile:suiteDes_Paht];
    
    UIButton *suite_IcoView = [UIButton buttonWithType:UIButtonTypeCustom];
    [suite_IcoView setImage:imageSuite_ico forState:UIControlStateNormal];
    
    UIImageView *suite_DesView = [[UIImageView alloc] initWithImage:imageSuite_Des];
    [suite_DesView setTag:55];
    
    [suite_IcoView setFrame:CGRectMake(22, 2 + imageSuite_Des.size.height - 65, imageSuite_ico.size.width / 2, imageSuite_ico.size.height / 2)];
    [suite_DesView setFrame:CGRectMake(-imageSuite_Des.size.width / 2, 2, imageSuite_Des.size.width / 2, imageSuite_Des.size.height / 2)];
    //
    suite_DesView.hidden = YES;
    [suite_IcoView addTarget:view action:@selector(suiteIcoBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:suite_DesView];
    [view addSubview:suite_IcoView];
    
    //
    //
    // 3.加载设计师头像 + 3D空间装换按钮
    
    // 背景图片
    NSString *icoBg = [NSString stringWithFormat:@"%@/%@",kLibrary,spaceProperty.ico_bg];
    UIImage *imageIcoBg = [UIImage imageWithContentsOfFile:icoBg];
    view.bgDesigner = [[UIImageView alloc] initWithImage:imageIcoBg];
    view.bg3dRoom = [[UIImageView alloc] initWithImage:imageIcoBg];
    [view.bgDesigner setFrame:CGRectMake(938, 6, 60, 60)];
    [view.bg3dRoom setFrame:CGRectMake(882, 6, 60, 60)];
    [view addSubview:view.bgDesigner];
    [view addSubview:view.bg3dRoom];
    
    // 文字标注
    UIImageView *imageviewDesigner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_space_designer.png"]];
    UIImageView *imageview3dRoom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_space_3droom.png"]];
    [imageviewDesigner setFrame:CGRectMake(954, 67, 31, 13)];
    [imageview3dRoom setFrame:CGRectMake(889, 67, 46, 12)];
    [view addSubview:imageview3dRoom];
    
    // 设计师头像 + 3D空间装换按钮
    UIButton *btnIco = [UIButton buttonWithType:UIButtonTypeCustom];
    NSArray *array = [spaceProperty.designer_ico componentsSeparatedByString:@","];
    
    NSString *icoPath = [NSString stringWithFormat:@"%@/%@",kLibrary,[array objectAtIndex:0]];
    
    UIImage *iconImage = [UIImage imageWithContentsOfFile:icoPath];
    
    if (iconImage)
    {
        [btnIco setBackgroundImage:iconImage forState:UIControlStateNormal];
        [btnIco setFrame:CGRectMake(930, -2, 68, 78)];//107, 123
        [btnIco setTag:[spaceProperty.spaceID intValue]];
        [btnIco addTarget:view action:@selector(btnIcoClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:imageviewDesigner];
        [view addSubview:btnIco];
    }
    else
    {
        view.bgDesigner.hidden = YES;
    }
    
    
    
    UIButton *btn3D = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3D setBackgroundImage:[UIImage imageNamed:@"3d_btn"] forState:UIControlStateNormal];
    [btn3D setFrame:CGRectMake(866, -10, 95, 95)];
    [btn3D setTag:0];
    [btn3D addTarget:view action:@selector(btn3DClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn3D];
    
    
    //    UIButton *btnIco = [UIButton buttonWithType:UIButtonTypeCustom];
    //    NSArray *array = [spaceProperty.designer_ico componentsSeparatedByString:@","];
    //
    //    NSString *icoPath = [NSString stringWithFormat:@"%@/%@",kLibrary,[array objectAtIndex:0]];
    //
    //    [btnIco setBackgroundImage:[UIImage imageWithContentsOfFile:icoPath] forState:UIControlStateNormal];
    //    [btnIco setFrame:CGRectMake(930, -2, 68, 78)];//107, 123
    //    [btnIco setTag:[spaceProperty.spaceID intValue]];
    //    [btnIco addTarget:view action:@selector(btnIcoClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIButton *btn3D = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn3D setBackgroundImage:[UIImage imageNamed:@"3d_btn"] forState:UIControlStateNormal];
    //    [btn3D setFrame:CGRectMake(870, -10, 95, 95)];
    //    [btn3D setTag:0];
    //    [btn3D addTarget:view action:@selector(btn3DClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [view addSubview:btnIco];
    //    [view addSubview:btn3D];
    
    // 4.添加 + 号按钮
    if (spaceProduct.count >0)
    {
        for (NSObject *obj in spaceProduct) {
            
            ModuleProduct *modulePro = (ModuleProduct *)obj;
            
            BrandSpaceButton *addBtn = [BrandSpaceButton buttonWithType:UIButtonTypeCustom];
            NSString *path = [NSString stringWithFormat:@"%@/%@",kLibrary,modulePro.product_ico];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:modulePro.type_id,@"typeid",spaceProperty.suiteid,@"suiteid", modulePro.product_detail, @"product_detail", nil];
            
            addBtn.brandSpaceDict = dict;
            
            UIImage *addImage = [UIImage imageWithContentsOfFile:path];
            [addBtn setImage:addImage forState:UIControlStateNormal];
            [addBtn setFrame:CGRectMake(0, 0, addImage.size.width /2, addImage.size.height /2)];
            CGPoint point = CGPointFromString(modulePro.product_position);
            
            [addBtn setCenter:point];
            [addBtn addTarget:view action:@selector(btnAddClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:addBtn];
        }
    }
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapEventReconizer:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapRecognizer];
    
    
    view.tapReconizer = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapAddBtnEventReconizer:)];
    tapRecognizer.numberOfTapsRequired = 1;
    
    return view;
}


// 设计师头像点击事件
-(void)btnIcoClickEvent:(UIButton *)sender
{
    if (alreadTouch) return;
    alreadTouch = YES;
    //1. 放大设计师头像
    BrandSpaceButton *btn = (BrandSpaceButton *)sender;
    
    _currentSelBtn = btn;
    
    NSArray *array = [self.spaceProperty.designer_ico componentsSeparatedByString:@","];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",kLibrary,[array objectAtIndex:1]];
    
    UIImage * designerImg = [UIImage imageWithContentsOfFile:path];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [btn setFrame:CGRectMake(920, -10, 107, 123)];
        
    } completion:^(BOOL finished) {
        
        UIImageView *imgContent = [[UIImageView alloc] initWithImage:designerImg];
        
        [imgContent setTag:TAG_DESIGNER];
        
        [imgContent setFrame:CGRectMake(0, 0, designerImg.size.width / 2, designerImg.size.height / 2)];
        
        [imgContent setCenter:CGPointMake(1024 - designerImg.size.width / 4 - 20, btn.center.y + designerImg.size.height / 4 + 25)];
        
        [self addSubview:imgContent];
        
    }];
    
    //2. 加载当前设计师的介绍信息
    
    //取消背景闪烁效果
    [self stopFlashLight];
    
}

// 点击缩回动画
-(void)tapEventReconizer:(UITapGestureRecognizer *)sender
{
    if (alreadTouch)
    {
        // 缩回设计师介绍图片
        UIImageView *desingerView = (UIImageView *)[self viewWithTag:TAG_DESIGNER];
        
        [UIView animateWithDuration:0.5f animations:^{
            
            [desingerView setAlpha:0];
            
        } completion:^(BOOL finished) {
            
            [desingerView removeFromSuperview];
            
            [UIView animateWithDuration:0.5f animations:^{
                
                [self.currentSelBtn setFrame:CGRectMake(930, -2, 68, 78)];
                
            } completion:^(BOOL finished) {
                
                alreadTouch = NO;
                
                //开始闪烁背景
                [self beginFlashLight];
            }];
            
        }];
    }
    
    
    if (alreadTouchSuite) {
        // 缩回套间介绍图片
        UIImageView *suiteDesView = (UIImageView *)[self viewWithTag:TAG_SUITE_DES];
        
        
        
        [UIView animateWithDuration:0.5f animations:^{
            
            
            
            //[self.currentSelBtn setFrame:CGPointMake(-suiteDesView.frame.size.width / 2,2)];
            [suiteDesView setCenter:CGPointMake(-suiteDesView.frame.size.width / 2, suiteDesView.center.y)];
            
        } completion:^(BOOL finished) {
            
            suiteDesView.hidden = YES;
            
            alreadTouchSuite = NO;
        }];
        
        
    }
}


// add + 号按钮点击事件
-(void)btnAddClickEvent:(BrandSpaceButton *)sender
{
    
    // 生成 查看更多 按钮
    if (!allowTouchAdd) return;
    
    allowTouchAdd = NO;
    
    self.currentAddBtn = sender;
    
    BrandSpaceButton *btn = sender;
    
    UIView *tapView;
    
    BrandSpaceButton *btnMore;
    
    
    tapView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:tapView];
    [tapView setTag:2000];
    [tapView addGestureRecognizer:self.tapReconizer];
    
    
    btnMore = [BrandSpaceButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:btnMore];
    [btnMore setTag:200];
    btnMore.brandSpaceDict = btn.brandSpaceDict;
    
    [btnMore addTarget:self action:@selector(btnMoreClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    // 由于已知图片尺寸，所以此处button的frame写死了
    [btnMore setBounds:CGRectZero];
    [btnMore setCenter:CGPointMake(btn.center.x, btn.center.y)];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [btn setTransform:CGAffineTransformMakeRotation(M_PI_4)];
        
        [btnMore setBounds:CGRectMake(0, 0, 160, 64)];
        [btnMore setCenter:CGPointMake(btn.center.x-95, btn.center.y+1.5)];
        
    } completion:^(BOOL finished) {
        
        NSString *product_detail = [btnMore.brandSpaceDict objectForKey:@"product_detail"];
        [btnMore setBackgroundImage:[[LibraryAPI sharedInstance] getImageFromPath:product_detail scale:1] forState:UIControlStateNormal];
        if (self.suiteColor)
        {
            [btnMore setTitleColor:_suiteColor forState:UIControlStateNormal];
        }
        
    }];
    
    /*
     
     [UIView animateWithDuration:1.5f animations:^{
     
     [btn setTransform:CGAffineTransformMakeRotation(- M_PI_4)];
     
     [btnMore setFrame:CGRectMake(btn.center.x + btn.frame.size.width / 2 + 10, btn.frame.origin.y, 0, 44)];
     
     } completion:^(BOOL finished) {
     
     UIButton *btnMoreA = (UIButton *)[self viewWithTag:200];
     UIView *tapView = (UIView *)[self viewWithTag:2000];
     
     [btnMoreA removeFromSuperview];
     [tapView removeFromSuperview];
     
     }];
     */
    
}


-(void)tapAddBtnEventReconizer:(UITapGestureRecognizer *)sender
{
    
    UIButton *btnMoreA = (UIButton *)[self viewWithTag:200];
    if (btnMoreA) {
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [self.currentAddBtn setTransform:CGAffineTransformMakeRotation(0)];
            // +号缩回动画
            [btnMoreA setBounds:CGRectZero];
            [btnMoreA setCenter:CGPointMake(btnMoreA.center.x+95, btnMoreA.center.y-1.5)];
            
        } completion:^(BOOL finished) {
            
            UIButton *btnMoreA = (UIButton *)[self viewWithTag:200];
            UIView *tapView = (UIView *)[self viewWithTag:2000];
            [tapView removeGestureRecognizer:self.tapReconizer];
            [btnMoreA removeFromSuperview];
            [tapView removeFromSuperview];
            
            allowTouchAdd = YES;
        }];
        
    }
}


-(void)btnMoreClickEvent:(BrandSpaceButton *)sender
{
    [self.delegate btnMoreClickEvent:sender WithSuiteColor:_suiteColor];
}



// 3D按钮点击事件
-(void)btn3DClickEvent:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(turnTo3DModulePageWith:)])
    {
        [self.delegate turnTo3DModulePageWith:self.spaceProperty];
    }
}

// 空间名称标题点击事件
-(void)suiteIcoBtnEvent:(UIButton *)sender
{
    if (alreadTouchSuite) return;
    
    alreadTouchSuite = YES;
    
    UIImageView *image = (UIImageView *)[self viewWithTag:55];
    
    image.hidden = NO;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        [image setCenter:CGPointMake(image.frame.size.width / 2, image.center.y)];
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}





@end
