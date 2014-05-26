//
//  LixilProductDetailView.m
//  LixilProductDetailView
//
//  Created by CY-003 on 13-11-13.
//  Copyright (c) 2013年 CY-003. All rights reserved.
//

#import "LixilProductDetailView.h"
#import "DatabaseOption+condition.h"
#import "DatabaseOption+DIYFolder.h"
#import "MacroDefine.h"
#import "LibraryAPI.h"
#import "Category.h"
#import "DatabaseOption+Union.h"
#import "DatabaseOption+Tfavorite.h"
#import "DatabaseOption+roomSceneImage.h"
#import "DatabaseOption+ColorIconAndImage.h"

#import "CartItem.h"
#import "Cart.h"
#import "CustomIOS7AlertView.h"
#import "Tdiyfolder.h"
#import "LixilBigDetailScrollView.h"

#define kProductSizeTag             250
#define kRoomSceneTag               500
#define kProductStandardTag         750
#define kColorButtonTagOffset       600
#define kRealeativeFirSubViewTag    800

#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

typedef NS_ENUM(NSInteger, ProductImageViewKind){
    ProductImageViewKindProductSize,
    ProductImageViewKindRoomScene,
    ProductImageViewKindProductStandard
};


@interface LixilProductDetailView () <InaxProductIntroViewDelegate,UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UIScrollViewDelegate>
{
    //产品图片
    __weak IBOutlet UIImageView *productImageView;
    
    
    /////////////////////包含右侧所有视图的滚动视图
    UIScrollView *rightScrollView;
    float rightViewContentHeight;  //右侧所有视图的高度之和
    
    //产品名称 英文名称
    UILabel *productName;
    UILabel *productEnglishName;
    
    //产品型号
    UILabel *productModelnumber;
    UILabel *productModelnumberLable;
    UIView *modelBackgroundView;
    
    //产品描述标签
    UILabel *productIntroLable;
    
    //产品描述文本视图
    UITextView *productDetailText;
    
    //产品包括型号
    UITextView *includeModel;
    UILabel *includeModelLable;
    //产品包括型号可能为图片
    UIImageView *includeImageView;
    
    //骊住门的规格图片
    UIImageView *standardImageView;
    
    //伊奈技术图标背景view
    UIView *iconView;
    
    //包含按钮的视图
    UIView *buttonContentView;
    
    
    //相关产品按钮    同系列产品/产品尺寸图/匹配产品/套间效果图    //////产品规格  伊康家呼吸砖专用
    UIButton *seriesProductButton;
    UIButton *productSizeButton;
    UIButton *matchProductButton;
    UIButton *roomSceneButton;
    
    UIButton *productStandardButton;//////
    
    /////////////////////////////////////////////////////// 伊康家不显示科技按钮
    
    __weak IBOutlet UIButton *techButton;
    __weak IBOutlet UILabel *techLable;
    
    ///////////////////////////////////////////////////////
    
    
    //相关产品滚动视图 产品视图
    __weak IBOutlet UIScrollView *relatedProductInfoScrollView;
    
    //产品颜色 滚动视图
    UIScrollView *productColorsScrollview;
    
    
    BOOL ifHadReload;
    
    ////////////参数lables
    
    UILabel *param1;    //外观尺寸
    UILabel *param2;    //冲水方式
    UILabel *param3;    //冲水量
    UILabel *param4;    //坑距
    UILabel *param5;    //进排水口标准间距
    UILabel *param6;    //要求水压
    UILabel *param7;    //供水方式
    UILabel *param8;    //供水压范围
    UILabel *param9;    //最大消费电力
    UILabel *param10;   //遥控器
    UILabel *param11;   //进水方式
    UILabel *param12;   //电力方式
    UILabel *param13;   //施工方式
    UILabel *param14;   //容量
    UILabel *param15;   //整体尺寸
    UILabel *param16;   //碗/台盆尺寸
    UILabel *param17;   //碗/台盆容量
    UILabel *param18;   //色号
    UILabel *param19;   //其他型号
    UILabel *param20;   //出水高度
    UILabel *param21;   //出水伸长 龙头
    UILabel *param22;   //抽拉管长度 龙头
    UILabel *param23;   //伊奈配件表面材
    UILabel *param24;   //伊奈配件内部芯材
    UILabel *param25;   //伊奈配件扶手支架外饰套
    UILabel *param26;   //伊奈配件各部连接套
    UILabel *param27;   //美标沐浴房 可选配件
    UILabel *param28;   //系列一览 骊住
    UILabel *param29;   //伊康家数量
    UILabel *param30;   //伊康家实际尺寸
    UILabel *param31;   //伊康家厚度
    UILabel *param32;   //伊康家所含内容
    UILabel *param33;   //骊住杰斯塔、万多斯产品等说明
    UILabel *param34;   //门把手
    UILabel *param35;   //玻璃款式
    UILabel *param36;   //所选款式
}

//选中的产品图像
@property (nonatomic , strong) UIImageView *selectedImageView;
//选中产品图像的绝对位置
@property (nonatomic , assign) CGRect orginRect;
//全屏显示的图像
@property (nonatomic , strong) LixilBigDetailScrollView *fullScreenImageView;
//产品施工图的高清图
@property (nonatomic , strong) NSMutableArray *orginProductSizeImage;
//套间效果图的高清图
@property (nonatomic , strong) NSMutableArray *orginRoomSceneImage;

//产品规格的高清图
@property (nonatomic , strong) NSMutableArray *orginProductStandardImage;//////

//现在显示的相关视图
@property (nonatomic , strong) UIView *currentRelatedView;

//房间效果视图
@property (nonatomic , strong) UIView *roomSceneView;
//产品施工视图
@property (nonatomic , strong) UIView *productSizeView;
//同系列产品视图
@property (nonatomic , strong) UIView *seriesProductView;
//匹配产品视图
@property (nonatomic , strong) UIView *matchProductView;

//产品规格视图
@property (nonatomic , strong) UIView *productStandardView;//////


//数据库
@property (nonatomic , strong) DatabaseOption *db;

// 文件夹选择
@property (nonatomic, strong) NSArray *pickerViewDS;
@property (nonatomic, strong) NSString *selectedFinderID;

@property (nonatomic , strong) NSArray *colorIconArray;  //产品不同颜色色块
@property (nonatomic , strong) NSArray *colorImageArray; //产品不同颜色大图
@property (nonatomic , strong) NSArray *colorNameArray; //产品不同颜色名称

@end

@implementation LixilProductDetailView

#pragma mark - 刷新视图 - 重新加载数据 -

- (void) reloadData
{
    if (!self.tProduct)
    {
        NSLog(@"self.tProduct = nil");
        return;
    }
    
    if (ifHadReload)
    {
        NSLog(@"had reload");
        return;
    }
    
    ////////初始化数组  依次加入数组

    rightViewContentHeight = 0;
    
    productImageView.image   = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,self.tProduct.image1]];
    
    productName.text         = [self deleteSpaceString:self.tProduct.name];
    
    rightViewContentHeight += productName.frame.size.height + 5;
    
    productEnglishName.text  = [self deleteSpaceString:self.tProduct.name_en];
    
    if (![self checkSpaceString:self.tProduct.name_en])
    {
        rightViewContentHeight = [self layoutRightViews:productEnglishName orginY:rightViewContentHeight] + 5;
    }
    else
    {
        productEnglishName.hidden = YES;
    }
    
    NSString *code = [[self deleteSpaceString:self.tProduct.code] stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
//    [self deleteSpaceString:self.tProduct.code]
    productModelnumber.text  = code;
    
    int modelLableHight = [self contentHightWithLable:productModelnumber];
    productModelnumber.frame = CGRectMake(productModelnumber.frame.origin.x, productModelnumber.frame.origin.y, productModelnumber.frame.size.width, modelLableHight);
    modelBackgroundView.frame = CGRectMake(modelBackgroundView.frame.origin.x, modelBackgroundView.frame.origin.y, modelBackgroundView.frame.size.width, modelLableHight);
    
    rightViewContentHeight = [self layoutRightViews:modelBackgroundView orginY:rightViewContentHeight] + 5;
    
    NSString *detailText = [self deleteSpaceString:[self.tProduct.feature stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];
    
    if (!detailText || !detailText.length)
    {
        productIntroLable.hidden = YES;
        productDetailText.hidden = YES;
    }
    else
    {
        productDetailText.text   = [detailText stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
        productDetailText.font   = [UIFont systemFontOfSize:15];   /////////先设置textview内容 再设置font才能正常显示
        
        float contentHeight      = [productDetailText contentHeight];
        
        if (contentHeight > 225)
        {
            contentHeight = 225;
        }
        
        productDetailText.frame  = CGRectMake(productDetailText.frame.origin.x, productDetailText.frame.origin.y, productDetailText.frame.size.width, contentHeight);
        
        rightViewContentHeight = [self layoutRightViews:productIntroLable orginY:rightViewContentHeight];
        
        rightViewContentHeight = [self layoutRightViews:productDetailText orginY:rightViewContentHeight] + 5;
    }
    
    
    ////////////////////////////////////////////////如果是伊康家呼吸砖 需重新生成一个text view 字体小一点  另外隐藏科技按钮
    
    if ([self.tProduct.type1 isEqualToString:@"45"])
    {
        techButton.hidden = YES;
        techLable.hidden = YES;
        
//        NSString *subText = [self deleteSpaceString:[[self.tProduct.param10 stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"] stringByReplacingOccurrencesOfString:@"\\r" withString:@""]];
//        
//        if (subText && subText.length)
//        {
//            UITextView *subTextview = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
//            subTextview.backgroundColor = [UIColor clearColor];
//            subTextview.textColor = [UIColor blackColor];
//            subTextview.font = [UIFont systemFontOfSize:14];
//            if ([subTextview respondsToSelector:@selector(setSelectable:)]) {
//                subTextview.selectable = NO;
//            }
//            subTextview.editable = NO;
//            subTextview.showsHorizontalScrollIndicator = NO;
//            subTextview.bounces = NO;
//            [rightScrollView addSubview:subTextview];
//            
//            
//            /////赋值 调整高度
//            subTextview.text = subText;
//            subTextview.font = [UIFont systemFontOfSize:13];
//            
//            float contentHeight = [subTextview contentHeight];
//            subTextview.frame  = CGRectMake(subTextview.frame.origin.x, subTextview.frame.origin.y, subTextview.frame.size.width, contentHeight);
//
//            rightViewContentHeight = [self layoutRightViews:subTextview orginY:rightViewContentHeight] + 5;
//        }
//        else
//        {
//            NSLog(@"伊康家副描述为空！");
//        }
    }

    ////////////////////////////////////////////////
    
    //////包括型号标签
    rightViewContentHeight = [self layoutRightViews:includeModelLable orginY:rightViewContentHeight];
   
    NSString *standardImagePath = nil;
    
    if (![self.tProduct.type1 isEqualToString:@"45"])  //////如果当前为伊康家呼吸砖 直接不显示
    {
        //如果骊住门的规格图片存在  显示
        standardImagePath = [self deleteSpaceString:self.tProduct.param33];
        
        if ([standardImagePath hasSuffix:@"png"])
        {
            standardImageView.hidden = NO;
            
            UIImage *standardImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,standardImagePath]];
            standardImageView.image = standardImage;
            
            rightViewContentHeight = [self layoutRightViews:standardImageView orginY:rightViewContentHeight] + 5;
        }
    }

    includeModel.text = [[self deleteSpaceString:self.tProduct.include_product] stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    
    //NSLog(@"包括型号:>>%@", [self deleteSpaceString:self.tProduct.include_product]);
    
    if ([self checkSpaceString:self.tProduct.include_product])//如果当前包括型号为空
    {
        includeModelLable.hidden = YES;
        includeModel.hidden = YES;
        
        if ([standardImagePath hasSuffix:@"png"] && ![self.tProduct.type1 isEqualToString:@"45"])
        {
            includeModelLable.hidden = NO;
            includeModelLable.text = @"产品说明:";
        }
        else
        {
            rightViewContentHeight -= (includeModelLable.frame.size.height + 5);
        }
    }
    else
    {
        //如果包括型号是一张图片  则不显示文字 显示图片
        if ([includeModel.text hasSuffix:@"png"])
        {
            UIImage *includeModelImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,includeModel.text]];
            includeImageView.image = includeModelImage;
            
            if (includeModelImage)
            {
                includeModel.text = nil;
                includeModel.hidden = YES;
                includeImageView.hidden = NO;
                
                rightViewContentHeight = [self layoutRightViews:includeImageView orginY:rightViewContentHeight] + 5;
            }
            else
            {
                includeModelLable.hidden = YES;
                includeModel.hidden = YES;
                
                NSLog(@"没找到包括型号图片");
            }
        }
        else
        {
            ////////调整包括型号textview高度
            
            NSString *convertText = [[includeModel.text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"] stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
            includeModel.text = convertText;
            
            float contentHeight = [includeModel contentHeight];
            includeModel.frame  = CGRectMake(includeModel.frame.origin.x, includeModel.frame.origin.y, includeModel.frame.size.width, contentHeight);
            
            rightViewContentHeight = [self layoutRightViews:includeModel orginY:rightViewContentHeight] + 5;
        }
    }
    
    ///////////////////////////params lable ////////////////////////
    
    rightViewContentHeight = [self layoutParamsLables:param1 string:[self.tProduct.param1 stringByReplacingOccurrencesOfString:@";" withString:@"\n"] orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param2 string:self.tProduct.param2 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param3 string:self.tProduct.param3 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param4 string:self.tProduct.param4 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param5 string:self.tProduct.param5 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param6 string:self.tProduct.param6 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param7 string:self.tProduct.param7 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param8 string:self.tProduct.param8 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param9 string:self.tProduct.param9 orginY:rightViewContentHeight];
    
    ////  param10 如果长度>10  说明是伊康家描述 不是遥控器  则不显示
    if (self.tProduct.param10.length < 10)
    {
        rightViewContentHeight = [self layoutParamsLables:param10 string:self.tProduct.param10 orginY:rightViewContentHeight];
    }
    
    rightViewContentHeight = [self layoutParamsLables:param11 string:self.tProduct.param11 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param12 string:self.tProduct.param12 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param13 string:self.tProduct.param13 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param14 string:self.tProduct.param14 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param15 string:self.tProduct.param15 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param16 string:self.tProduct.param16 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param17 string:self.tProduct.param17 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param18 string:self.tProduct.param18 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param19 string:self.tProduct.param19 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param20 string:self.tProduct.param20 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param21 string:self.tProduct.param21 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param22 string:self.tProduct.param22 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param23 string:self.tProduct.param23 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param24 string:self.tProduct.param24 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param25 string:self.tProduct.param25 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param26 string:self.tProduct.param26 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param27 string:self.tProduct.param27 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param28 string:self.tProduct.param28 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param29 string:self.tProduct.param29 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param30 string:self.tProduct.param30 orginY:rightViewContentHeight];
    //rightViewContentHeight = [self layoutParamsLables:param31 string:self.tProduct.param31 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param32 string:self.tProduct.param32 orginY:rightViewContentHeight];
    //rightViewContentHeight = [self layoutParamsLables:param33 string:self.tProduct.param33 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param34 string:self.tProduct.param34 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param35 string:self.tProduct.param35 orginY:rightViewContentHeight];
    rightViewContentHeight = [self layoutParamsLables:param36 string:self.tProduct.param36 orginY:rightViewContentHeight];
    
    ///////////////////////////params lable ////////////////////////
    
    //伊奈科技icon显示
    if (![self checkSpaceString:self.tProduct.pImg])
    {
        rightViewContentHeight += 5;
        
        iconView.frame = CGRectMake(iconView.frame.origin.x, rightViewContentHeight, iconView.frame.size.width, iconView.frame.size.height);
        
        [self showIconWithIconPathArray:[self.tProduct.pImg componentsSeparatedByString:@","]];
        
        int iconRows = (([self.tProduct.pImg componentsSeparatedByString:@","].count - 1)/ 3) + 1;
        
        if (!iconRows) {
            iconRows = 1;
        }
        
        rightViewContentHeight += (iconRows * 60);
    }
    else
    {
        iconView.hidden = YES;
    }
    
    
    
    //玄关门显示不同颜色图片
    if ([self.tProduct.param10 hasSuffix:@"png"])
    {
        rightViewContentHeight -= 5;
        
        //创建标签
        UILabel *lable = [self creatParamsLablesWithTitle:@"颜色选择:"];
        lable.hidden = NO;
        
        rightViewContentHeight += lable.frame.size.height;
        
        NSString *imageName = self.tProduct.param10;
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imageName]];
        
        if (image)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
            imageView.image = image;
            
            UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, imageView.frame.size.width, 190)];
            sv.contentSize = imageView.frame.size;
            [sv addSubview:imageView];
            
            [rightScrollView addSubview:sv];
            
            rightViewContentHeight += sv.frame.size.height + 5;
        }
        else
        {
            NSLog(@"玄关门图片没有找到:%@",[NSString stringWithFormat:@"%@/%@",kLibrary,imageName]);
        }
    }
    
    rightScrollView.contentSize = CGSizeMake(rightScrollView.contentSize.width, rightViewContentHeight);
    
    
    /////////////////////////////////////设置右侧视图的滚动范围
    
    
    [self reloadRelatedView];
    
    
    ////////添加不同颜色产品的按钮
    
    NSDictionary *dic = [self.db colorIconArrayAndImageArrayWithProductID:self.tProduct.productid];
    
    if (dic)
    {
        NSArray *iconPathArray  = [dic objectForKey:COLOR_ICON];
        NSArray *imagePathArray = [dic objectForKey:COLOR_IMAGE];
        
        if (iconPathArray && iconPathArray.count && imagePathArray && imagePathArray.count)
        {
            NSMutableArray *tempIconArray  = [NSMutableArray array];
            NSMutableArray *tempImageArrzy = [NSMutableArray array];
            
            for (int i = 0; i < iconPathArray.count; i++)
            {
                UIImage *iconImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,[iconPathArray objectAtIndex:i]]];
                UIImage *colorImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,[imagePathArray objectAtIndex:i]]];
                
                if (!iconImage)
                {
                    //NSLog(@"icon image == nil");
                    continue;
                }
                
                if (!colorImage)
                {
                    //NSLog(@"color image == nil");
                    continue;
                }
                
                [tempIconArray  addObject:iconImage];
                [tempImageArrzy addObject:colorImage];
                
            }
            
            
            self.colorIconArray  = tempIconArray;
            self.colorImageArray = tempImageArrzy;
            self.colorNameArray = [dic objectForKey:COLOR_NAME];
            
            [self creatColorsButtonWithColorImageArray:self.colorIconArray];
        }
    }
    
    
    ifHadReload = YES;
    
    //NSLog(@"-  - - -- - - - - -- - -产品ID:      %@  ",self.tProduct.productid);
    NSLog(@"-  - - -- - - - - -- - -产品型号:     %@  ",self.tProduct.code);
}

- (float) layoutParamsLables:(UILabel *)lable string:(NSString *)string orginY:(float)orginY
{
    if (string && [self deleteSpaceString:string] && ![[self deleteSpaceString:string] isEqualToString:@""])
    {
        lable.hidden = NO;
        lable.text = [lable.text stringByAppendingString:string];
        int h = [self contentHightWithLable:lable];
        lable.frame = CGRectMake(lable.frame.origin.x,orginY, lable.frame.size.width, h);
        orginY += lable.frame.size.height;
    }
    
    return orginY;
}

- (float) layoutRightViews:(UIView *)view orginY:(float)orginY
{
    view.frame = CGRectMake(view.frame.origin.x,orginY, view.frame.size.width, view.frame.size.height);
    
    orginY += view.frame.size.height;
    
    return orginY;
}



//删除字符串最后的空白
- (NSString *) deleteSpaceString:(NSString *)string
{
    if (!string || !string.length) {
        return nil;
    }
    
    while (1)
    {
        if (!string.length) {
            break;
        }
        
        if ([[string substringWithRange:NSMakeRange(string.length-1,1)] isEqualToString:@" "])
        {
            string = [string substringWithRange:NSMakeRange(0, string.length-1)];
        }
        else
        {
            break;
        }
    }
    
    return string;
}

//根据icon图片路径数组在iconview上生成对应的icon图标

- (void) showIconWithIconPathArray:(NSArray *)pathArray
{
    int iconCount = [pathArray count];
    
    if (!iconCount) {
        return;
    }
    
    for (int i = 0; i<iconCount; i++)
    {
        if (i > 8)
        {
            break;
        }
        
        int v = i / 3;    //行
        int h = i % 3;    //列
        
        UIImage *iconImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,[pathArray objectAtIndex:i]]];
        
        //CGSize iconSize = iconImage.size;
        
        //NSLog(@"size%d : %@",i,NSStringFromCGSize(iconSize));
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(h*(50+10) + (25 - iconImage.size.width / 4), v*(50+10) + (25 - iconImage.size.height / 4), iconImage.size.width / 2, iconImage.size.height / 2)];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        iconImageView.image = iconImage;
        iconImageView.backgroundColor = [UIColor clearColor];
        [iconView addSubview:iconImageView];
        
        //NSLog(@"iconView %d frame : %@",i,NSStringFromCGRect(iconImageView.frame));
    }
}

//重新绘制相关产品视图
- (void) reloadRelatedView
{
    for (UIView *view in relatedProductInfoScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (!self.currentRelatedView) {
        return;
    }
    
    relatedProductInfoScrollView.contentSize = self.currentRelatedView.frame.size;
    [relatedProductInfoScrollView addSubview:self.currentRelatedView];
}


#pragma mark - creat related content view -

/////创建产品规格视图
- (UIView *) creatProductStandardView
{
    if (![self.tProduct.type1 isEqualToString:@"45"])
    {
        productStandardButton.hidden = YES;
        return nil;
    }
    
    NSString *imagePath = [self deleteSpaceString:self.tProduct.param33];
    
    NSMutableArray *orginImageArray = [NSMutableArray array];
    NSMutableArray *scaleImageArray = [NSMutableArray array];
    
    UIImage *orginImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imagePath]];
    UIImage *scaleImage = [[LibraryAPI sharedInstance] getImageFromPath:imagePath scale:2];
    
    if (!orginImage || !scaleImage)
    {
        productStandardButton.hidden = YES;
        return nil;
    }
    
    [orginImageArray addObject:orginImage];
    [scaleImageArray addObject:scaleImage];
    
    if (![scaleImageArray count])
    {
        productStandardButton.hidden = YES;
        return nil;
    }
    
    self.orginProductStandardImage = orginImageArray;
    
    return [self creatRelatedViewWithImageArray:scaleImageArray kind:ProductImageViewKindProductStandard];
}

- (UIView *) creatRoomSceneView
{
    if (!self.tProduct.type2 || ![self deleteSpaceString:self.tProduct.type2])
    {
        roomSceneButton.hidden = YES;
        return nil;
    }
    
    NSString *imagePath = [self.db roomSceneImagePathWithProductID:self.tProduct.productid];
    
    NSArray *imagePathArray = [imagePath componentsSeparatedByString:@","];
    
    NSMutableArray *orginImageArray = [NSMutableArray array];
    NSMutableArray *scaleImageArray = [NSMutableArray array];
    
    for (NSString *imgPath in imagePathArray)
    {
        UIImage *orginImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imgPath]];
        UIImage *scaleImage = [[LibraryAPI sharedInstance] getImageFromPath:imgPath scale:8];
        
        if (!orginImage || !scaleImage) {
            continue;
        }
        
        [orginImageArray addObject:orginImage];
        [scaleImageArray addObject:scaleImage];
    }
    
    if (![scaleImageArray count])
    {
        roomSceneButton.hidden = YES;
        return nil;
    }
    
    self.orginRoomSceneImage = orginImageArray;
    
    return [self creatRelatedViewWithImageArray:scaleImageArray kind:ProductImageViewKindRoomScene];
}


- (UIView *) creatProductSizeView
{
    /////根据image5返回的字符串 以;为标志分割切成n个图片路径
    /////根据图片路径数组生成图片数组
    /////添加原始图像数组  根据选中的imageview 的tag从数组中获取高清图

    if (!self.tProduct.image5 || ![self deleteSpaceString:self.tProduct.image5])
    {
        productSizeButton.hidden = YES;
        return nil;
    }
    
    NSArray *imagePathArray = [self.tProduct.image5 componentsSeparatedByString:@","];
    
    NSMutableArray *orginImageArray = [NSMutableArray array];
    NSMutableArray *scaleImageArray = [NSMutableArray array];
    
    for (NSString *imgPath in imagePathArray)
    {
        //NSLog(@"imgpath %@ ",[NSString stringWithFormat:@"%@/%@",kLibrary,imgPath]);
        
        UIImage *orginImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imgPath]];
        UIImage *scaleImage = [[LibraryAPI sharedInstance] getImageFromPath:imgPath scale:8];
        
        if (!orginImage || !scaleImage) {
            continue;
        }
        
        [orginImageArray addObject:orginImage];
        [scaleImageArray addObject:scaleImage];
    }
    
    self.orginProductSizeImage = orginImageArray;
    
    if (!scaleImageArray.count)
    {
        scaleImageArray = nil;
        self.orginProductSizeImage = nil;
        return nil;
    }
    
    return [self creatRelatedViewWithImageArray:scaleImageArray kind:ProductImageViewKindProductSize];
}

- (UIView *) creatSeriesProductView
{
    NSArray *result = nil;
    
    result = [self.db union_productIDArrayWithProductID:self.tProduct.productid type:@"1"];
    
    //    if ([self.tProduct.type1 isEqualToString:@"42"])////////////铝合金门窗
    //    {
    //        result = [self.db union_productIDArrayWithProductID:self.tProduct.productid type:@"1"];
    //        //result = [self.db union_productIDArrayWithProductID:self.tProduct.productid type:@"2"];
    //    }
    //    else if ([self.tProduct.brand isEqualToString:@"1"])////////如果当前产品品牌是骊住产品  则同类产品从tproduct中查询 否则从union中查询
    //    {
    //        //NSString *sql = [NSString stringWithFormat:@"select id from tproduct where type2 in (select type2 from tproduct where id = %@) and id <> %@ order by type1 asc",self.tProduct.productid,self.tProduct.productid];
    //
    //        //result = [self.db productIDArrayByConditionSQL:sql];      注释掉的是查询骊住门方法
    //
    //        result = [self.db union_productIDArrayWithProductID:self.tProduct.productid type:@"1"];
    //
    //    }
    //    else
    //    {
    //        result = [self.db union_productIDArrayWithProductID:self.tProduct.productid type:@"1"];
    //    }
    
    if (!result || ![result count])
    {
        seriesProductButton.hidden = YES;
        return nil;
    }
    
    result = [self deleteSpaceID:result];
    
    return [self creatRelatedViewWithArray:result];
}

- (UIView *) creatMatchProductView
{
    NSArray *result = nil;
    
    if ([self.tProduct.type1 isEqualToString:@"42"])////////////铝合金门窗
    {
        NSString *sql = [NSString stringWithFormat:@"select id from tproduct where type2 in (select type2 from tproduct where id = %@) and id <> %@ and param31 = 1 order by type1 asc",self.tProduct.productid,self.tProduct.productid];
        
        result = [self.db productIDArrayByConditionSQL:sql];
    }
    else
    {
        result = [self.db union_productIDArrayWithProductID:self.tProduct.productid type:@"2"];
    }
    
    if (!result || ![result count])
    {
        matchProductButton.hidden = YES;
        return nil;
    }
    
    result = [self deleteSpaceID:result];
    
    return [self creatRelatedViewWithArray:result];
}

- (NSArray *) deleteSpaceID:(NSArray *)array
{
    NSMutableArray *temp = [NSMutableArray array];
    
    for (NSString *str in array)
    {
        if ([[self deleteSpaceString:str] isEqualToString:@""] || ![self deleteSpaceString:str] || [str isEqualToString:@"0"])
        {
            continue;
        }
        else
        {
            [temp addObject:str];
        }
    }
    
    return temp;
}

- (UIView *) creatRelatedViewWithImageArray:(NSArray *)array kind:(ProductImageViewKind)kind
{
    int pageCount = array.count / 4;
    
    if (array.count % 4) {
        pageCount++;
    }
    
    UIView *rv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 668*pageCount, 160)];
    
    int gap = 9;
    int page = 0;
    
    for (int i = 0; i < [array count]; i++)
    {
        page = i / 4;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i*(160 + gap) - page*(gap-1) , 0, 160, 160)];
        iv.image = array[i];
        iv.backgroundColor = [UIColor whiteColor];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.userInteractionEnabled = YES;
        [rv addSubview:iv];
        
        if (kind == ProductImageViewKindProductSize)
        {
            iv.tag = kProductSizeTag + i;
        }
        else if (kind == ProductImageViewKindRoomScene)
        {
            iv.tag = kRoomSceneTag + i;
        }
        else if (kind == ProductImageViewKindProductStandard)
        {
            iv.tag = kProductStandardTag + i;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeProductImageViewFullScreen:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [iv addGestureRecognizer:tap];
    }
    
    return rv;
}

- (UIView *) creatRelatedViewWithArray:(NSArray *)array
{
    int pageCount = array.count / 4;
    
    if (array.count % 4) {
        pageCount++;
    }
    
    UIView *rv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 668*pageCount, 160)];
    
    int gap = 9;
    int page = 0;
    
    for (int i = 0; i < [array count]; i++)
    {
        page = i / 4;
        
        NSString *pid = array[i];
        
        if ([[self deleteSpaceString:pid] isEqualToString:@""] || ![self deleteSpaceString:pid] || [pid isEqualToString:@"0"])
        {
            continue;
        }
        
        InaxProductIntroView *piv = [[InaxProductIntroView alloc] initWithFrame:CGRectMake(i*(160 + gap) - page*(gap-1) , 0, 160, 160)];
        piv.productid = array[i];
        piv.delegate = self;
        [piv reloadData];
        [rv addSubview:piv];
        rv.tag = kRealeativeFirSubViewTag;
    }
    
    return rv;
}

#pragma mark - button touched -

//套间效果图按钮
- (void)roomSceneButton
{
    [self changeButtonStatusWith:roomSceneButton];
    
    self.currentRelatedView = self.roomSceneView;
    [self reloadRelatedView];
}

//同系列产品按钮
- (void)seriesProductButtonTouched
{
    [self changeButtonStatusWith:seriesProductButton];
    
    self.currentRelatedView = self.seriesProductView;
    [self reloadRelatedView];
}

//相关产品按钮
- (void)matchProductButtonTouched
{
    [self changeButtonStatusWith:matchProductButton];
    
    self.currentRelatedView = self.matchProductView;
    [self reloadRelatedView];
}

//产品尺寸图按钮
- (void)productSizeButtonTouched
{
    [self changeButtonStatusWith:productSizeButton];
    
    self.currentRelatedView = self.productSizeView;
    [self reloadRelatedView];
}

//产品规格按钮
- (void)productStandardButtonTouched
{
    [self changeButtonStatusWith:productStandardButton];
    
    self.currentRelatedView = self.productStandardView;
    [self reloadRelatedView];
}

//改变按钮透明度
- (void) changeButtonStatusWith:(UIButton *) button
{
    relatedProductInfoScrollView.contentOffset = CGPointMake(0, 0);
    
    if (!seriesProductButton.hidden) {
        seriesProductButton.alpha = 0.5;
    }
    if (!matchProductButton.hidden) {
        matchProductButton.alpha = 0.5;
    }
    if (!productSizeButton.hidden) {
        productSizeButton.alpha = 0.5;
    }
    if (!roomSceneButton.hidden) {
        roomSceneButton.alpha = 0.5;
    }
    if (!productStandardButton.hidden) {
        productStandardButton.alpha = 0.5;
    }
    
    button.alpha = 1;
}

#pragma mark - user operate button -

//荣誉
- (IBAction)honour:(id)sender
{
    
}

//播放产品视频信息
- (IBAction)playAudio:(id)sender
{
    
}

//文件夹按钮
- (IBAction)folderButtonTouched:(id)sender
{
    DatabaseOption *dbo = [[DatabaseOption alloc]init];
    self.pickerViewDS = [dbo selectAllFolders];
    
    if (!self.pickerViewDS.count)
    {
        [UIAlertView showAlertViewWithTitle:@"没有文件夹" message:@"请新建文件夹"];
        return;
    }
    self.selectedFinderID = ((Tdiyfolder *)self.pickerViewDS[0]).tdiyfolderid;
    
    
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    [alertView setContainerView:[self createPickerView]];
    alertView.buttonTitles = @[@"确定", @"取消"];
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        if (buttonIndex == 0) {
            if ([dbo insertFolderDetail:self.tProduct folderID:self.selectedFinderID]) {
                [UIAlertView showAlertViewWithTitle:@"成功" message:@"添加到文件夹成功"];
            } else {
                [UIAlertView showAlertViewWithTitle:@"失败" message:@"添加到文件夹失败"];
            }
        }
        [alertView close];
    }];
    [alertView show];
    
}

//收藏按钮
- (IBAction)storeButtonTouched:(id)sender
{
    DatabaseOption *dbo = [[DatabaseOption alloc]init];
    int i = [dbo addFavoriteProduct:self.tProduct];
    if (i==-1) {
        [UIAlertView showAlertViewWithTitle:@"已经添加过" message:@"请勿重复添加"];
    } else if (i == 1){
        [UIAlertView showAlertViewWithTitle:@"成功" message:@"添加成功"];
    } else {
        [UIAlertView showAlertViewWithTitle:@"失败" message:@"添加失败"];
    }
}

//购物车按钮
- (IBAction)buyButtonTouched:(id)sender
{
    CartItem *item = [[CartItem alloc]init];
    item.good = self.tProduct;
    item.duihaoStatus = YES;
    [[Cart sharedInstance] addProduct:item AndCount:1];
    [UIAlertView showAlertViewWithTitle:@"成功" message:@"添加购物车成功"];
}

//文本按钮
- (IBAction)textIntro:(id)sender
{
    
}


//点击图片全屏显示
- (void) makeProductImageViewFullScreen:(UITapGestureRecognizer *)sender
{
    self.selectedImageView = (UIImageView *)sender.view;
    
    if (self.selectedImageView == productImageView)
    {
        self.orginRect = self.selectedImageView.frame;
    }
    else if(self.selectedImageView == includeImageView || self.selectedImageView == standardImageView)
    {
        self.orginRect = CGRectMake(rightScrollView.frame.origin.x,
                                    rightScrollView.frame.origin.y + self.selectedImageView.frame.origin.y,
                                    self.selectedImageView.frame.size.width,
                                    self.selectedImageView.frame.size.height);
    }
    else
    {
        //此处还需斟酌
        self.orginRect = CGRectMake(relatedProductInfoScrollView.frame.origin.x + self.selectedImageView.frame.origin.x - relatedProductInfoScrollView.contentOffset.x,
                                    relatedProductInfoScrollView.frame.origin.y + self.selectedImageView.frame.origin.y,
                                    self.selectedImageView.frame.size.width,
                                    self.selectedImageView.frame.size.height);
    }
    
    self.fullScreenImageView = [[LixilBigDetailScrollView alloc] initWithFrame:self.orginRect];
    self.fullScreenImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //////判断tag 赋给不同图片
    int page = 0;
    NSArray *imagearray = nil;
    if ((self.selectedImageView.tag >= kProductSizeTag) && (self.selectedImageView.tag < (kProductSizeTag + 50)))
    {
        //产品施工图
        imagearray = self.orginProductSizeImage;
        page =  self.selectedImageView.tag - kProductSizeTag;
        
       // self.fullScreenImageView.image = [self.orginProductSizeImage objectAtIndex:(self.selectedImageView.tag - kProductSizeTag)];
    }
    else if ((self.selectedImageView.tag >= kRoomSceneTag) && (self.selectedImageView.tag < (kRoomSceneTag + 50)))
    {
        //房间效果图
        
        imagearray = self.orginRoomSceneImage;
        page =  self.selectedImageView.tag - kRoomSceneTag;
        
      //  self.fullScreenImageView.image = [self.orginRoomSceneImage objectAtIndex:(self.selectedImageView.tag - kRoomSceneTag)];
    }
    else if ((self.selectedImageView.tag >= kProductStandardTag) && (self.selectedImageView.tag< (kProductStandardTag + 50)))
    {
        
       
            imagearray = self.orginProductStandardImage;
            page =  self.selectedImageView.tag - kProductStandardTag;
            
        
        //产品规格图
        
      
        
      //  self.fullScreenImageView.image = [self.orginProductStandardImage objectAtIndex:(self.selectedImageView.tag - kProductStandardTag)];
    }
    else
    {
        
        if (self.selectedImageView == productImageView)
        {
            //获取图片数组
            NSMutableArray  *arrayImage = [NSMutableArray array];
            UIView  *bgView = [self.currentRelatedView viewWithTag:kRealeativeFirSubViewTag];
            
            int count = 0;
            if (self.selectedImageView.image)
            {
                [arrayImage addObject:self.selectedImageView.image];
                //count++;
            }
            
            for (InaxProductIntroView *infoView in bgView.subviews)
            {
                if ([infoView isKindOfClass:[InaxProductIntroView class]])
                {
                    UIImage *image = [infoView getProductImage];
                   
                    if (image)
                    {
                        if ([self.productid isEqualToString:infoView.productid])
                        {
                            page = count;
                        }
                      //  debugLog(@"self.productid:%@ infoView.productid:%@ page:%d",self.productid,infoView.productid,page);
                        
                        [arrayImage addObject:image];
                        count++;
                    }
                }
            }
            
            if (arrayImage.count)
            {
                imagearray = [NSArray arrayWithArray:arrayImage];
                
            }else
            {
                imagearray = @[self.selectedImageView.image];
            }
           
            
            
        }else
        {
            imagearray = @[self.selectedImageView.image];
            page =  0;
            
        }
     
        //产品图片
       // self.fullScreenImageView.image = self.selectedImageView.image;
    }
    
    
    self.fullScreenImageView.imageArray = imagearray;
    self.fullScreenImageView.origiRect = self.orginRect;
    self.fullScreenImageView.page = page;
    
    self.fullScreenImageView.alpha = 0;
    
    self.fullScreenImageView.backgroundColor        = [UIColor whiteColor];
    self.fullScreenImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.fullScreenImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullScreen)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired    = 1;
    [self.fullScreenImageView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^
     {
         self.fullScreenImageView.frame = CGRectMake(0, 0, 1024, 768);
         self.fullScreenImageView.alpha = 1;
     }];
}

//点击全屏显示的图片恢复正常显示
- (void) dismissFullScreen
{
    [UIView animateWithDuration:0.3 animations:^{
        self.fullScreenImageView.frame = self.orginRect;
        self.fullScreenImageView.alpha = 0;
    } completion:^(BOOL finished)
     {
         [self.fullScreenImageView removeFromSuperview];
         self.fullScreenImageView = nil;
         self.selectedImageView   = nil;
     }];
}

#pragma mark - InaxProductIntroViewDelegate -

-(void)didSelectProductIntroView:(InaxProductIntroView *)productIntroView
{
    LixilProductDetailView *pdv = [[LixilProductDetailView alloc] init];
    pdv.productid = productIntroView.productid;
    
    UINavigationController *nvc = self.navigationController;
    [nvc pushViewController:pdv animated:NO];
}

#pragma mark - viewDidLoad -

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.db = [[DatabaseOption alloc] init];
    
    //为产品图像添加手势 点击可以全屏显示
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeProductImageViewFullScreen:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [productImageView addGestureRecognizer:tap];
    productImageView.userInteractionEnabled = YES;
    
    
    //生成控件
    [self initSomeStaff];
    
    ifHadReload = NO;
}

- (void) initSomeStaff
{
    rightViewContentHeight = 0;
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(714, 100, 300, 500)];
    rightScrollView.backgroundColor = [UIColor clearColor];
    rightScrollView.bounces = NO;
    rightScrollView.contentSize = rightScrollView.frame.size;
    [self.view addSubview:rightScrollView];
    
    productName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
    productName.font = [UIFont systemFontOfSize:16];
    productName.text = @"产品中文名称";
    productName.adjustsFontSizeToFitWidth = YES;
    [rightScrollView addSubview:productName];
    
    rightViewContentHeight += productName.frame.size.height + 8; //gap = 8
    
    productEnglishName = [[UILabel alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 25)];
    productEnglishName.font = [UIFont systemFontOfSize:15];
    productEnglishName.text = @"产品英文名称";
    productEnglishName.adjustsFontSizeToFitWidth = YES;
    [rightScrollView addSubview:productEnglishName];
    
    rightViewContentHeight += productEnglishName.frame.size.height + 8;
    
    //产品型号标签 背景view
    modelBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 25)];
    modelBackgroundView.backgroundColor = [UIColor clearColor];
    [rightScrollView addSubview:modelBackgroundView];
    //型号标签
    productModelnumberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 76, 25)];
    productModelnumberLable.text = @"产品型号:";
    productModelnumberLable.font = [UIFont systemFontOfSize:15];
    [modelBackgroundView addSubview:productModelnumberLable];
    //型号内容
    productModelnumber = [[UILabel alloc] initWithFrame:CGRectMake(76, 0, 224, 25)];
    productModelnumber.text = @"code";
    productModelnumber.adjustsFontSizeToFitWidth = NO;
    productModelnumber.numberOfLines = 0;
    productModelnumber.font = [UIFont systemFontOfSize:15];
    [modelBackgroundView addSubview:productModelnumber];
    
    rightViewContentHeight += modelBackgroundView.frame.size.height + 8;
    
    //产品描述标签
    productIntroLable = [[UILabel alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 76, 25)];
    productIntroLable.text = @"产品描述:";
    productIntroLable.font = [UIFont systemFontOfSize:15];
    [rightScrollView addSubview:productIntroLable];
    
    rightViewContentHeight += productIntroLable.frame.size.height;
    //////
    
    productDetailText = [[UITextView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 225)];
    productDetailText.backgroundColor = [UIColor clearColor];
    productDetailText.textColor = [UIColor blackColor];
    productDetailText.font = [UIFont systemFontOfSize:15];
    if ([productDetailText respondsToSelector:@selector(setSelectable:)]) {
        productDetailText.selectable = NO;
    }
    productDetailText.editable = NO;
    productDetailText.showsHorizontalScrollIndicator = NO;
    productDetailText.bounces = NO;
    [rightScrollView addSubview:productDetailText];
    
    rightViewContentHeight += productDetailText.frame.size.height + 5;
    
    includeModelLable = [[UILabel alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 75, 25)];
    includeModelLable.text = @"包括型号:";
    includeModelLable.font = [UIFont systemFontOfSize:15];
    [rightScrollView addSubview:includeModelLable];
    
    rightViewContentHeight += includeModelLable.frame.size.height;
    
    includeModel = [[UITextView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 45)];
    includeModel.backgroundColor = [UIColor clearColor];
    includeModel.textColor = [UIColor blackColor];
    includeModel.font = [UIFont systemFontOfSize:15];
    if ([includeModel respondsToSelector:@selector(setSelectable:)]) {
        includeModel.selectable = NO;
    }
    includeModel.editable = NO;
    includeModel.showsHorizontalScrollIndicator = NO;
    includeModel.bounces = NO;
    [rightScrollView addSubview:includeModel];
    
    rightViewContentHeight += includeModel.frame.size.height + 5;
    
    iconView = [[UIView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 170, 170)];
    iconView.userInteractionEnabled = YES;
    iconView.backgroundColor = [UIColor clearColor];
    [rightScrollView addSubview:iconView];
    
    includeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 150)];
    includeImageView.contentMode = UIViewContentModeScaleAspectFit;
    includeImageView.backgroundColor = [UIColor clearColor];
    includeImageView.tag = 902;
    [rightScrollView addSubview:includeImageView];
    includeImageView.hidden = YES;
    
    standardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 200)];
    standardImageView.contentMode = UIViewContentModeScaleAspectFit;
    standardImageView.backgroundColor = [UIColor clearColor];
    standardImageView.tag = 901;
    [rightScrollView addSubview:standardImageView];
    standardImageView.hidden = YES;
    
    [self addTapToFullScreen:includeImageView];
    [self addTapToFullScreen:standardImageView];
    
    ////////按钮相关视图
    buttonContentView = [[UIView alloc] initWithFrame:CGRectMake(18, 543, 600, 32)];
    [self.view addSubview:buttonContentView];
    
    roomSceneButton = [self creatButtonWithTitle:@"空间图" andFrame:CGRectMake(0, 0, 74, 32)];
    [roomSceneButton addTarget:self action:@selector(roomSceneButton) forControlEvents:UIControlEventTouchUpInside];
    
    productSizeButton = [self creatButtonWithTitle:@"产品施工图" andFrame:CGRectMake(0, 0, 105, 32)];
    [productSizeButton addTarget:self action:@selector(productSizeButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    seriesProductButton = [self creatButtonWithTitle:@"同类产品" andFrame:CGRectMake(0, 0, 92, 32)];
    [seriesProductButton addTarget:self action:@selector(seriesProductButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 同系列
//    if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"1"]) {
        matchProductButton = [self creatButtonWithTitle:@"同系列产品" andFrame:CGRectMake(0, 0, 105, 32)];
//    } else {
//        matchProductButton = [self creatButtonWithTitle:@"关联产品" andFrame:CGRectMake(0, 0, 92, 32)];
//    }
    
    [matchProductButton addTarget:self action:@selector(matchProductButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    productStandardButton = [self creatButtonWithTitle:@"产品规格" andFrame:CGRectMake(0, 0, 92, 32)];
    [productStandardButton addTarget:self action:@selector(productStandardButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    //////颜色
    productColorsScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, productImageView.frame.size.height - 50, 300, 50)];
    productColorsScrollview.contentSize = productColorsScrollview.frame.size;
    productColorsScrollview.backgroundColor = [UIColor clearColor];
    productColorsScrollview.bounces = NO;
    productColorsScrollview.hidden = YES;
    [productImageView addSubview:productColorsScrollview];
    
    
    
    /////////////////////////////params
    
    param1 = [self creatParamsLablesWithTitle:@"外观尺寸:"];
    param2 = [self creatParamsLablesWithTitle:@"冲水方式:"];
    param3 = [self creatParamsLablesWithTitle:@"冲水量:"];
    param4 = [self creatParamsLablesWithTitle:@"坑距:"];
    param5 = [self creatParamsLablesWithTitle:@"进排水口标准间距:"];
    param6 = [self creatParamsLablesWithTitle:@"要求水压:"];
    param7 = [self creatParamsLablesWithTitle:@"供水方式:"];
    param8 = [self creatParamsLablesWithTitle:@"供水压范围:"];
    param9 = [self creatParamsLablesWithTitle:@"最大消费电力:"];
    param10 = [self creatParamsLablesWithTitle:@"遥控器:"];
    param11 = [self creatParamsLablesWithTitle:@"进水方式:"];
    param12 = [self creatParamsLablesWithTitle:@"电力方式:"];
    param13 = [self creatParamsLablesWithTitle:@"施工方式:"];
    param14 = [self creatParamsLablesWithTitle:@"容量:"];
    param15 = [self creatParamsLablesWithTitle:@"整体尺寸:"];
    param16 = [self creatParamsLablesWithTitle:@"台盆尺寸:"];//碗/台盆尺寸
    param17 = [self creatParamsLablesWithTitle:@"台盆容量:"];//碗/台盆容量®
    param18 = [self creatParamsLablesWithTitle:@"色号:"];
    param19 = [self creatParamsLablesWithTitle:@"其他型号:"];
    param20 = [self creatParamsLablesWithTitle:@"出水高度:"];
    param21 = [self creatParamsLablesWithTitle:@"出水伸长:"];
    param22 = [self creatParamsLablesWithTitle:@"抽拉管长度:"];
    param23 = [self creatParamsLablesWithTitle:@"伊奈配件表面材:"];
    param24 = [self creatParamsLablesWithTitle:@"伊奈配件内部芯材:"];
    param25 = [self creatParamsLablesWithTitle:@"伊奈配件扶手支架外饰套:"];
    param26 = [self creatParamsLablesWithTitle:@"伊奈配件各部连接套:"];
    param27 = [self creatParamsLablesWithTitle:@"美标沐浴房 可选配件:"];
    param28 = [self creatParamsLablesWithTitle:@"系列一览 骊住:"];
    param29 = [self creatParamsLablesWithTitle:@"伊康家数量:"];
    param30 = [self creatParamsLablesWithTitle:@"伊康家实际尺寸:"];
    param31 = [self creatParamsLablesWithTitle:@"伊康家厚度:"];
    param32 = [self creatParamsLablesWithTitle:@"伊康家所含内容:"];
    param33 = [self creatParamsLablesWithTitle:@"骊住杰斯塔、万多斯产品等说明:"];
    param34 = [self creatParamsLablesWithTitle:@"门把手:"];
    param35 = [self creatParamsLablesWithTitle:@"玻璃款式:"];
    param36 = [self creatParamsLablesWithTitle:@"可选款式:"];
}

//检查字符串是否为空 为空返回true
- (BOOL) checkSpaceString:(NSString *)string
{
    if (string && [self deleteSpaceString:string] && ![[self deleteSpaceString:string] isEqualToString:@""])
    {
        return false;
    }
    
    return true;
}

//计算标签文本高度  +8 是上下留空白空间 +0.5 是取整
- (int) contentHightWithLable:(UILabel *)lable
{
    float height = [lable.text sizeWithFont:lable.font constrainedToSize:CGSizeMake(lable.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height;
    int returnHeight = (int)(height + 8 + 0.5);
    
    return returnHeight;
}

- (UILabel *) creatParamsLablesWithTitle:(NSString *) title
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, rightViewContentHeight, 300, 25)];
    lable.text = title;
    lable.font = [UIFont systemFontOfSize:15];
    lable.adjustsFontSizeToFitWidth = YES;
    lable.backgroundColor = [UIColor clearColor];
    lable.numberOfLines = 5;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.hidden = YES;
    [rightScrollView addSubview:lable];
    return lable;
}

- (void) creatColorsButtonWithColorImageArray:(NSArray *)colorImageArray
{
    if (!colorImageArray || !colorImageArray.count) {
        return;
    }
    
    productColorsScrollview.hidden = NO;
    
    int gap = 6; //按钮之间的间隔
    
    for (int i = 0; i < colorImageArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((productColorsScrollview.frame.size.height+gap)*i, 0, productColorsScrollview.frame.size.height, productColorsScrollview.frame.size.height);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[colorImageArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = kColorButtonTagOffset + i;
        [button addTarget:self action:@selector(colorButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [productColorsScrollview addSubview:button];
    }
    
    int contentWidth = (productColorsScrollview.frame.size.height+gap)*colorImageArray.count - gap;
    
    productColorsScrollview.frame = CGRectMake(productColorsScrollview.frame.origin.x, productColorsScrollview.frame.origin.y, contentWidth, productColorsScrollview.frame.size.height);
    productColorsScrollview.contentSize = productColorsScrollview.frame.size;
}

- (void) colorButtonTouched:(UIButton *) button
{
    int buttonIndex = button.tag - kColorButtonTagOffset;
    //NSLog(@"color button index %d",buttonIndex);
    productImageView.image = [self.colorImageArray objectAtIndex:buttonIndex];
    productModelnumber.text = [self.colorNameArray objectAtIndex:buttonIndex];
}

- (UIButton *) creatButtonWithTitle:(NSString *) title andFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.backgroundColor = [UIColor clearColor];
    button.hidden = YES;
    [buttonContentView addSubview:button];
    return button;
}

- (UIImageView *) spearateImage
{
    UIImageView *sp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2, 32)];
    sp.image = [UIImage imageNamed:@"inax_dv_shutiao"];
    sp.backgroundColor = [UIColor clearColor];
    
    return sp;
}

- (void) addTapToFullScreen:(UIImageView *) imageView
{
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeProductImageViewFullScreen:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [imageView addGestureRecognizer:tap];
}

#pragma mark - viewWillAppear & viewDidAppear -

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.productid && ![self.productid isEqualToString:@""])
    {
        self.tProduct = [self.db tProductByProductID:self.productid];
    }
    
    self.productSizeView     = [self creatProductSizeView];
    self.roomSceneView       = [self creatRoomSceneView];
    self.seriesProductView   = [self creatSeriesProductView];
    self.matchProductView    = [self creatMatchProductView];
    self.productStandardView = [self creatProductStandardView];
    
    [self layoutButtons];
    
    [self reloadData];
}

- (void) layoutButtons
{
    if (!self.roomSceneView && !self.productSizeView && !self.seriesProductView && !self.matchProductView)
    {
        buttonContentView.hidden = YES;
    }
    
    ////////////////////////////////////////////////////////如果当前是伊奈品牌  关联产品改为同系列产品  修改按钮宽度
    if ([self.tProduct.brand isEqualToString:@"3"])
    {
        [matchProductButton setTitle:@"同系列产品" forState:UIControlStateNormal];
        matchProductButton.frame = CGRectMake(0, 0, 105, 32);
    }
    ///////////////////////////////////////////////////////
    
    int buttonContentWitdh = 0;
    
    UIImageView *spearate = [self spearateImage];
    
    [buttonContentView addSubview:spearate];
    buttonContentWitdh += 2;///////分隔条的宽度
    
    if (self.roomSceneView)
    {
        buttonContentWitdh = [self addButtonContentWidth:roomSceneButton orginWitdh:buttonContentWitdh];
    }
    
    if (self.productSizeView)
    {
        buttonContentWitdh = [self addButtonContentWidth:productSizeButton orginWitdh:buttonContentWitdh];
    }
    
    if (self.seriesProductView)
    {
        buttonContentWitdh = [self addButtonContentWidth:seriesProductButton orginWitdh:buttonContentWitdh];
    }
    
    if (self.matchProductView)
    {
        buttonContentWitdh = [self addButtonContentWidth:matchProductButton orginWitdh:buttonContentWitdh];
    }
    
    
    
    ////////////////////////////////////////////////////////如果当前是骊住品牌  显示关联产品  且伊康家呼吸砖不显示
    
    if ([self.tProduct.brand isEqualToString:@"1"] && !self.matchProductView && ![self.tProduct.type1 isEqualToString:@"45"])
    {
        buttonContentWitdh = [self addButtonContentWidth:matchProductButton orginWitdh:buttonContentWitdh];
        
        buttonContentView.hidden = NO;
    }
    
    ////////////////////////////////////////////////////////
    
    ///////如果是伊康家呼吸砖  显示产品规格
    
    if (self.productStandardView)
    {
        buttonContentWitdh = [self addButtonContentWidth:productStandardButton orginWitdh:buttonContentWitdh];
    }
    
    ////////////////////////////////////////////////////////
    
    
    if (self.productSizeView)
    {
        [self changeButtonStatusWith:productSizeButton];
        self.currentRelatedView = self.productSizeView;
    }
    else if (self.seriesProductView)
    {
        [self changeButtonStatusWith:seriesProductButton];
        self.currentRelatedView = self.seriesProductView;
    }
    else if (self.matchProductView)
    {
        [self changeButtonStatusWith:matchProductButton];
        self.currentRelatedView = self.matchProductView;
    }
    else if (self.roomSceneView)
    {
        [self changeButtonStatusWith:roomSceneButton];
        self.currentRelatedView = self.roomSceneView;
    }
    else if (self.productStandardView)
    {
        [self changeButtonStatusWith:productStandardButton];
        self.currentRelatedView = self.productStandardView;
    }
    
}

- (int) addButtonContentWidth:(UIButton *) button  orginWitdh:(int) buttonContentWitdh
{
    button.frame = CGRectMake(buttonContentWitdh, 0, button.frame.size.width, button.frame.size.height);
    buttonContentWitdh += button.frame.size.width;
    
    UIImageView *spearate = [self spearateImage];
    spearate.frame = CGRectMake(buttonContentWitdh, 0, 2, 32);
    [buttonContentView addSubview:spearate];
    buttonContentWitdh += 2;
    
    button.hidden = NO;
    
    return buttonContentWitdh;
}


#pragma mark - initWithNibName -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - didReceiveMemoryWarning -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerViewDS.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return ((Tdiyfolder *)self.pickerViewDS[row]).foldername;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedFinderID = ((Tdiyfolder *)self.pickerViewDS[row]).tdiyfolderid;
}

#pragma mark - Init

- (UIPickerView *)createPickerView
{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.backgroundColor = [UIColor grayColor];
    return pickerView;
}

- (void)initFolderData
{
    DatabaseOption *dbo = [[DatabaseOption alloc]init];
    self.pickerViewDS = [dbo selectAllFolders];
}


@end
