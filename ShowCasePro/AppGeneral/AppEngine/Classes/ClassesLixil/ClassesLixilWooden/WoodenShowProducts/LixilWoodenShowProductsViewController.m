//
//  LixilWoodenShowProductsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#define TableView_Width                 leftBgimageView.frame.size.width
#define TableView_Height                683
#define TableView_Cell_Height_Master    171
#define TableView_Cell_Height_Detail    85

#define Animation_Duration              0.25

#define Cell_Imageview_Tag              27366

#define Inax_Sp_Detail_Array            @"Inax_Sp_Detail_Array"
#define Inax_Sp_Detail_Bgimage          @"Inax_Sp_Detail_Bgimage"

#define Inax_Sp_ImageName               @"Inax_Sp_ImageName"
#define Inax_Sp_TypeID                  @"Inax_Sp_TypeID"


#define Collection_Cell_Identifier      @"InaxShowProductsCell"

#define Collection_Cell_ImageView_Tag   11
#define Collection_Cell_Lable_Tag       22
#define BottomImageViewBeginTag         1000
#define Detail_btn_bg_tag               8001
#define ADDVIEWTAG                      234546


#import "LixilWoodenShowProductsViewController.h"
#import "DatabaseOption+condition.h"
#import "LixilProductDetailView.h"
#import "LibraryAPI.h"
#import "LixilBigDetailScrollView.h"
#import "LiXiWoodenWholeBodyView.h"
#import "LixilWoodenproductSyleView.h"

typedef enum
{
    JFProductsTypeNone,
    JFProductsTypedingzhi,  //工厂定制
    JFProductsTypeKaifeili, //康扉骊
    JFProductsTypeLinaiduo  //丽耐多
}JFProductsType;
@interface LixilWoodenShowProductsViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,LixilWoodenproductSyleViewdelegate>
{
    __weak IBOutlet UIImageView *bgImageView;
    
    __weak IBOutlet UIImageView *leftBgimageView;
    
    __weak IBOutlet UICollectionView *productsCollectionView;
    
    
    UIView *tableViewContentView;   //加在leftbgimageview上  其中包含两个tableview
    
    UITableView *masterTableView;   //大类别
    UITableView *detailTableView;   //小类别
    JFProductsType      m_iCurrentType;
}

@property (nonatomic , strong) NSArray *master_deatil_Data;     //包含所有子类别的数组  存放顺序与master一致

@property (nonatomic , strong) NSArray *masterData;             //大类数组

@property (nonatomic , strong) NSArray *detailData;             //单个子类别的数组

@property (nonatomic , strong) DatabaseOption *dbo;

@property (nonatomic , strong) NSArray *productsArray;          //查询出的所有产品数组


@property (nonatomic , strong) NSArray *selectBgImagesArray;
@property (nonatomic , strong) NSArray *unselectImagesArray;
@end

@implementation LixilWoodenShowProductsViewController


#pragma mark - collection view data source -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Collection_Cell_Identifier forIndexPath:indexPath];
    
    if (indexPath.row < self.productsArray.count)
    {
        cell.hidden = NO;
        
        Tproduct *product = (Tproduct *)[self.productsArray objectAtIndex:indexPath.row];
        
        UIImageView *productImg = (UIImageView *)[cell viewWithTag:Collection_Cell_ImageView_Tag];
        productImg.image = nil;
        
        // scale image in background
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *endImage = [[LibraryAPI sharedInstance] getImageFromPath:product.image1 scale:4];
            dispatch_async(dispatch_get_main_queue(), ^{
                productImg.image = endImage;  
            });
        });
        
        UILabel *productCode = (UILabel *)[cell viewWithTag:Collection_Cell_Lable_Tag];
        productCode.text  = [self deleteSpaceString:product.code];
        
    } else
    {
        cell.hidden = YES;
    }
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.productsArray) {
        return self.productsArray.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - collection view delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.productsArray.count)
    {
        NSLog(@"error : collectionView:didSelectItemAtIndexPath: 数组越界.");
        return;
    }
    
    Tproduct *product = [self.productsArray objectAtIndex:indexPath.row];
    
    //NSLog(@"product name : %@",product.name);
    
    LixilProductDetailView *pdv = [LixilProductDetailView new];
    pdv.productid = product.productid;
    
    [self.navigationController pushViewController:pdv animated:NO];
}

#pragma mark - table view data source -

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ////////////////////////////////////////////////////////////////////////////////////
    
    if (tableView == masterTableView)
    {
        static NSString *masterIdentifier = @"Inax_Sp_Master_Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:masterIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:masterIdentifier];
            
            cell.frame = CGRectMake(0, 0, TableView_Width, TableView_Cell_Height_Master);
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TableView_Width, TableView_Cell_Height_Master)];
            imageView.tag = Cell_Imageview_Tag;
            imageView.backgroundColor = [UIColor clearColor];
            [cell addSubview:imageView];
            
            cell.backgroundColor = [UIColor clearColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row >= self.masterData.count) {
            return cell;
        }
        
        NSDictionary *dic = [self.masterData objectAtIndex:indexPath.row];
        NSString *imageName = [dic objectForKey:Inax_Sp_ImageName];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:Cell_Imageview_Tag];
        imageView.image = image;
        
        return cell;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    static NSString *detailIdentifier = @"Inax_Sp_Detail_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailIdentifier];
        
        cell.frame = CGRectMake(0, 0, TableView_Width, TableView_Cell_Height_Detail);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 0, TableView_Width, TableView_Cell_Height_Detail)];
        imageView.tag = Cell_Imageview_Tag;
        imageView.backgroundColor = [UIColor clearColor];
        [cell addSubview:imageView];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (!self.detailData || (indexPath.row >= self.detailData.count)) {
        return cell;
    }
    
    NSDictionary *dic = [self.detailData objectAtIndex:indexPath.row];
    NSString *imageName = [dic objectForKey:Inax_Sp_ImageName];
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:Cell_Imageview_Tag];
    imageView.frame = CGRectMake(17, TableView_Cell_Height_Detail - 17 - image.size.height/2, image.size.width/2, image.size.height/2);
    imageView.image = image;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == masterTableView)
    {
        return self.masterData.count;
    }
    
    if (!self.detailData) {
        return 0;
    }
    
    return self.detailData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == masterTableView)
    {
        return TableView_Cell_Height_Master;
    }
    
    return TableView_Cell_Height_Detail;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - table view delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == masterTableView)
    {
        //点击地板或者收纳
        if (indexPath.row > 1) {
            NSLog(@"地板 收纳 暂时没有");
            return;
        }
        
        NSDictionary *detailDic = [self.master_deatil_Data objectAtIndex:indexPath.row];
        
        NSArray *detailArray = [detailDic objectForKey:Inax_Sp_Detail_Array];
        NSString *bgImageName = [detailDic objectForKey:Inax_Sp_Detail_Bgimage];
        
        [self pushToDetailTableView:detailArray bgImageName:bgImageName];
    }
    else
    {
        if (!self.detailData || (indexPath.row >= self.detailData.count)) {
            return;
        }
        
        NSDictionary *detailDic = [self.detailData objectAtIndex:indexPath.row];
        NSString *type_id = [detailDic objectForKey:Inax_Sp_TypeID];
        
        NSString *sql =[NSString stringWithFormat:@"select * from tproduct where type3 = %@ and brand = 1 and param31 = 1",type_id];
        
        self.productsArray = [self.dbo productArrayByConditionSQL:sql];
        
        
        
        //工程定制产品
        if ([type_id intValue] == 145334625)
        {
            m_iCurrentType = JFProductsTypedingzhi;
            NSString *sql =[NSString stringWithFormat:@"select * from tproduct where type3 = %@ and brand = 1 and param31 = 1",@"138"];
            
            NSMutableArray  *arrayProduct = [NSMutableArray array];
            self.productsArray = [self.dbo productArrayByConditionSQL:sql];
            
           // 工程定制产品的产品 获取丽耐多BKB之后的产品
            BOOL add = NO;
            for (int i = 0; i < self.productsArray.count; i++)
            {
                
                Tproduct *product = (Tproduct *)[self.productsArray objectAtIndex:i];
                if (!add)
                {
                    NSString  *code = product.code;
                    if ([code isEqualToString:@"BKB"])
                    {
                        add = YES;
                    }
                }
                
                if (add)
                {
                    [arrayProduct addObject:product];
                }
                
            }
            
            if (arrayProduct.count) {
                self.productsArray = [NSArray arrayWithArray:arrayProduct];
            }
            [self setBtnBgHidden:NO];
        }else if ([type_id integerValue] == 137)
        {
            m_iCurrentType = JFProductsTypeKaifeili;
            [self setBtnBgHidden:NO];
            
            
        }else if ([type_id integerValue] == 138)
        {
             m_iCurrentType = JFProductsTypeLinaiduo;
             [self setBtnBgHidden:NO];
            
        }
        
        else
        {
            [self setBtnBgHidden:YES];
        }
        if (!self.productsArray || !self.productsArray.count)
        {
            NSLog(@"error : 无数据.");
            
            if (!productsCollectionView.hidden)
            {
                productsCollectionView.hidden = YES;
            }
            return;
        }
        
        [productsCollectionView reloadData];
        
        productsCollectionView.hidden = NO;
    }
}


#pragma mark - 切换tableview -

- (BOOL) isMasterView
{
    if (tableViewContentView.frame.origin.x == 0)
    {
        return YES;
    }
    
    return NO;
}

- (void) moveToDetailView
{
    [UIView animateWithDuration:Animation_Duration animations:^
     {
         CGRect frame = tableViewContentView.frame;
         frame.origin.x -= TableView_Width;
         tableViewContentView.frame = frame;
         [self setBtnBgHidden:YES];
     }];
}

- (void) moveToMasterView
{
    [UIView animateWithDuration:Animation_Duration animations:^
     {
         CGRect frame = tableViewContentView.frame;
         frame.origin.x = 0;
         tableViewContentView.frame = frame;
         [self setBtnBgHidden:YES];
     }];
}

- (void) pushToDetailTableView:(NSArray *)dataArray bgImageName:(NSString *)imageName
{
    [self changeBackgroundImage:imageName];
    self.detailData = dataArray;
    [detailTableView reloadData];
    [self moveToDetailView];
}

- (void) popToMasterTableView
{
    productsCollectionView.hidden = YES;
    
    [self changeBackgroundImage:nil];
    [self moveToMasterView];
    self.detailData = nil;
}


#pragma mark - 更换背景图片 -

//nil 改回默认图片
- (void) changeBackgroundImage:(NSString *)imageName
{
    if (!imageName)
    {
        imageName = @"wooden_sp_bg.png";
    }
    
    UIImage *bgImage = [UIImage imageNamed:imageName];
    
    if (!bgImage)
    {
        NSLog(@"error : InaxShowProductsViewController : changeBackgroundImage : 找不到图片.");
        return;
    }
    bgImageView.image = bgImage;
}


#pragma mark - 覆盖父类的返回方法  如果当前在detail table view 就pop to master tableview 否则就调用pop view controller -

- (void) backButtonEvent
{
    if (![self isMasterView])
    {
        [self popToMasterTableView];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}


#pragma mark - life cycle -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dbo = [DatabaseOption new];
    
    //初始化数据   以后可以换成从数据库读取
    self.masterData = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObject:@"wooden_sp_xuanguanmen.png" forKey:Inax_Sp_ImageName],  //玄关门
                       [NSDictionary dictionaryWithObject:@"wooden_sp_shineimen.png" forKey:Inax_Sp_ImageName],//室内门
                       [NSDictionary dictionaryWithObject:@"wooden_sp_diban.png" forKey:Inax_Sp_ImageName],//地板
                       [NSDictionary dictionaryWithObject:@"wooden_sp_shouna.png" forKey:Inax_Sp_ImageName], //收纳
                       nil];
    
    NSArray *xuanguanmen = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjects:@[@"wooden_sp_xuanguanmen_jiesita.png",@"131"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"wooden_sp_xuanguanmen_wanduosi.png",@"132"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"wooden_sp_xuanguanmen_gulilai.png",@"130"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       nil];
    
    
    NSArray *shineimen = [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjects:@[@"wooden_sp_shineijiancai_gongchengdingzhi.png",@"145334625"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"wooden_sp_shineijiancai_kangfeili.png",@"137"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"wooden_sp_shineijiancai_linaiduo.png",@"138"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                          nil];

    
    self.master_deatil_Data = [NSArray arrayWithObjects:
                               [NSDictionary dictionaryWithObjects:@[xuanguanmen,@"wooden_sp_xuanguanmen_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[shineimen,@"wooden_sp_shineijiancai_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               nil];
    
    /////初始化viewd
    leftBgimageView.clipsToBounds = YES;
    
    tableViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableView_Width*2, TableView_Height)];
    tableViewContentView.backgroundColor = [UIColor clearColor];
    [leftBgimageView addSubview:tableViewContentView];
    
    masterTableView = [self creatTableView:CGRectMake(0, 0, TableView_Width, TableView_Height)];
    detailTableView = [self creatTableView:CGRectMake(TableView_Width, 0, TableView_Width, TableView_Height)];
    
    [masterTableView reloadData];
    
    

    [self setBtnBgHidden:YES];
    [self initCollectionView];
}

//初始化 collection view
- (void) initCollectionView
{
    productsCollectionView.dataSource = self;
    productsCollectionView.delegate = self;
    
    productsCollectionView.hidden = YES;
    
    [productsCollectionView registerNib:[UINib nibWithNibName:@"InaxShowProductsCell" bundle:nil] forCellWithReuseIdentifier:@"InaxShowProductsCell"];
}

- (UITableView *) creatTableView:(CGRect)frame
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor whiteColor];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.tableFooterView = [UIView new];
    
    [tableViewContentView addSubview:tableView];
    
    return tableView;
}

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

#pragma mark bottom bar code
//显示下面的按钮
-(void)setBtnBgHidden:(BOOL)hide
{
    
    
    if (hide)
    {
          m_iCurrentType = JFProductsTypeNone;
    }
     productsCollectionView.userInteractionEnabled = YES;
    UIView  *bgView = [self.view viewWithTag:Detail_btn_bg_tag];
    bgView.hidden = hide;
    
    
    UIImageView  *addView = (UIImageView*)[self.view viewWithTag:ADDVIEWTAG];
    [addView removeFromSuperview];
    
    
    CGRect frame = productsCollectionView.frame;
    if (!hide)
    {
        frame.size.height =  683-54;
        [bgView removeFromSuperview];
        switch (m_iCurrentType)
        {
            case JFProductsTypedingzhi:
                [self addBtnInbottom:@[@"bottom_btn_xilie_pressed.png",@"bottom_btn_wholebody_pressed.png",@"bottom_btn_style_pressed.png",@"bottom_btn_tedian_pressed.png",@"bottom_btn_fangan_pressed.png",@"bottom_btn_wujin_pressed.png"] unselecrimage:@[@"bottom_btn_xilie_word.png",@"bottom_btn_wholebody_word.png",@"bottom_btn_style_word.png",@"bottom_btn_tedian_word.png",@"bottom_btn_fangan_word.png",@"bottom_btn_wujin_word.png"]];
                //@[@"bottom_btn_xilie_word.png",@"bottom_btn_wholebody_word.png",@"bottom_btn_style_word.png",@"bottom_btn_tedian_word.png",@"bottom_btn_fangan_word.png",@"bottom_btn_wujin_word.png"]
                
                break;
           
            case JFProductsTypeLinaiduo:
            case JFProductsTypeKaifeili:
                [self addBtnInbottom:@[@"product_xilie_btn.png",@"product_compare_btn.png",@"product_shineizhuangshicai_btn.png",@"product_peijianwujin_btn.png"] unselecrimage:nil];
                
                break;
                
            default:
                break;
        }
        
        
        

    }else
    {
        frame.size.height =  683;
    }
    [productsCollectionView setFrame:frame];
    bgView = [self.view viewWithTag:Detail_btn_bg_tag];

    
    if (!hide)
    {
        [self selectWithView:(UIImageView*)[bgView viewWithTag:BottomImageViewBeginTag]];
        bgView = [self.view viewWithTag:ADDVIEWTAG];
        [bgView removeFromSuperview];
        
    }
    
}

-(void)selectWithView:(UIImageView*)imageView
{
    if (self.unselectImagesArray.count)
    {
        int count  = imageView.tag - BottomImageViewBeginTag;
        UIView  *bgView = [self.view viewWithTag:Detail_btn_bg_tag];
        for (int i = 0; i < self.unselectImagesArray.count; i++)
        {
            UIImageView *tempImageView = (UIImageView*)[bgView viewWithTag:BottomImageViewBeginTag+i];
            UIImageView *subView = (UIImageView*)[tempImageView viewWithTag:123];
            if (i == count)
            {
                subView.hidden = YES;
                UIImage *image = [UIImage imageNamed:[self.selectBgImagesArray objectAtIndex:i]];
                [tempImageView setImage:image];
                
            }else
            {
                subView.hidden = NO;
                tempImageView.image = nil;
            }
        }
        
       
        
    }else
    {
        UIView  *bgView = [self.view viewWithTag:Detail_btn_bg_tag];
        for (int i = 0; i < self.selectBgImagesArray.count; i++)
        {
            UIImageView *tempImageView = (UIImageView*)[bgView viewWithTag:BottomImageViewBeginTag+i];
            tempImageView.image =  nil;
        }
        
        imageView.image = [UIImage imageNamed:self.selectBgImagesArray[imageView.tag-BottomImageViewBeginTag]];
    }
}

-(void)selectWithButton:(UIButton*)sender
{
    UIView  *bgView = [self.view viewWithTag:Detail_btn_bg_tag];
    for (int i = 0; i < self.selectBgImagesArray.count; i++)
    {
        UIButton    *btnTemp = (UIButton*)[bgView viewWithTag:BottomImageViewBeginTag+i];
        [btnTemp setSelected:NO];
    }   [sender setSelected:YES];
}
-(void)addBtnInbottom:(NSArray*)arraySelectbgImageNames unselecrimage:(NSArray*)arrayUnselectImageNames
{
    
    self.selectBgImagesArray = arraySelectbgImageNames;
    self.unselectImagesArray = arrayUnselectImageNames;
    CGFloat fXpoint = 273;
    CGFloat ftotalwidth = self.view.frame.size.width-fXpoint;
    CGFloat fwidth = roundf(ftotalwidth/(arraySelectbgImageNames.count*1.0));
    CGFloat fheight = 54;
    CGFloat fYpoint = self.view.frame.size.height-fheight;
    UIView  *bgView = [[UIView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, self.view.frame.size.width-fXpoint, fheight)];
    if (m_iCurrentType == JFProductsTypedingzhi)
    {
        bgView.layer.contents = (id)[UIImage imageNamed:@"product_bottom_bg.png"].CGImage;
    }else
    {
        bgView.layer.contents = (id)[UIImage imageNamed:@"kang_li_bottom_bg.png"].CGImage;
    }
    
    [self.view addSubview:bgView];
    bgView.tag = Detail_btn_bg_tag;
    
    fXpoint = 0;
    for (int i = 0; i < arraySelectbgImageNames.count; i++)
    {
        
      //  fwidth = [[UIImage imageNamed:arraySelectbgImageNames[i]] size].width/2;
        UIImageView   *imageTemp = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, 0, fwidth, fheight)];
        
        //增加小图片
        UIImageView    *imageSmallView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageSmallView.tag = 123;
        [imageTemp addSubview:imageSmallView];
        
        if (arrayUnselectImageNames)
        {
            UIImage *image = [UIImage imageNamed:arrayUnselectImageNames[i]];
            [imageSmallView setImage:image];
            [imageSmallView setFrame:CGRectMake((fwidth-image.size.width/2)/2, (fheight-image.size.height/2)/2, image.size.width/2, image.size.height/2)];
        }else
        {
            [imageTemp setImage:nil];
        }
        [bgView addSubview:imageTemp];
        imageTemp.userInteractionEnabled = YES;
        imageTemp.tag = BottomImageViewBeginTag+i;
        fXpoint += fwidth;
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDetailBtn:)];
        [imageTemp addGestureRecognizer:tap];

    }
    
}
/*
-(void)addBtnInbottom:(NSArray*)arraySelectbgImageNames unselecrimage:(NSArray*)arrayUnselectImageNames
{
    
    self.selectBgImagesArray = arraySelectbgImageNames;
    self.unselectImagesArray = arrayUnselectImageNames;
    CGFloat fXpoint = 273;
    CGFloat ftotalwidth = self.view.frame.size.width-fXpoint;
    CGFloat fwidth = roundf(ftotalwidth/(arraySelectbgImageNames.count*1.0));
    CGFloat fheight = 54;
    CGFloat fYpoint = self.view.frame.size.height-fheight;
    UIView  *bgView = [[UIView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, self.view.frame.size.width-fXpoint, fheight)];
    if (m_iCurrentType == JFProductsTypedingzhi)
    {
        bgView.layer.contents = (id)[UIImage imageNamed:@"product_bottom_bg.png"].CGImage;
    }else
    {
        bgView.layer.contents = (id)[UIImage imageNamed:@"kang_li_bottom_bg.png"].CGImage;
    }
   
    [self.view addSubview:bgView];
    bgView.tag = Detail_btn_bg_tag;
    
    fXpoint = 0;
    for (int i = 0; i < arraySelectbgImageNames.count; i++)
    {
        
        fwidth = [[UIImage imageNamed:arraySelectbgImageNames[i]] size].width/2;
        UIButton   *btnTemp = [[UIButton alloc] initWithFrame:CGRectMake(fXpoint, 0, fwidth, fheight)];
        [btnTemp setBackgroundImage:[UIImage imageNamed:arraySelectbgImageNames[i]] forState:UIControlStateSelected];
        [btnTemp setBackgroundImage:nil forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed:arrayUnselectImageNames[i]];
        [btnTemp setImage:[UIImage imageNamed:arrayUnselectImageNames[i]] forState:UIControlStateNormal];
        [btnTemp setImage:nil forState:UIControlStateSelected];
        
        
        [btnTemp setImageEdgeInsets:UIEdgeInsetsMake((btnTemp.frame.size.height-image.size.height/2)/2, (btnTemp.frame.size.width-image.size.width/2)/2, (btnTemp.frame.size.height-image.size.height/2)/2, (btnTemp.frame.size.width-image.size.width/2)/2)];
        [bgView addSubview:btnTemp];
      //  [btnTemp.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btnTemp addTarget:self action:@selector(clickDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
        btnTemp.tag = BottomImageViewBeginTag+i;
        fXpoint += fwidth;
    }
        
}*/
-(void)clickDetailBtn:(id)sender
{
    int tag = 1000;
    if ([sender isKindOfClass:[UIButton class]])
    {
        tag = [sender tag];
        [self selectWithButton:sender];
        
    }else
    {
         tag = [[sender view] tag];
         [self selectWithView:(UIImageView*)[sender view]];
    }


    
    
    UIImageView  *addView = (UIImageView*)[self.view viewWithTag:ADDVIEWTAG]; //返回的不一定是UIImageView class的实例,需要仔细斟酌
    [addView removeFromSuperview];
    addView = nil;
    
   
    BOOL    isWholeBoby = NO;//是否是一体化解决方案
    if (m_iCurrentType == JFProductsTypedingzhi)
    {
        switch (tag)
        {
            case BottomImageViewBeginTag+3:
                addView = [[[NSBundle mainBundle] loadNibNamed:@"LixiCustomTedianView" owner:sender options:nil] lastObject];
                
                break;
            case BottomImageViewBeginTag+1://一体化View
                
                
                isWholeBoby = YES;
                addView = [[[NSBundle mainBundle] loadNibNamed:@"LiXiWoodenWholeBodyView" owner:self options:nil] lastObject];
                break;
            case BottomImageViewBeginTag+2:
                
            {
                
                LixilWoodenproductSyleView  *infoView  = (LixilWoodenproductSyleView*)[[[NSBundle mainBundle] loadNibNamed:@"LixilWoodenproductSyleView" owner:self options:nil] lastObject];
                infoView.delegate = self;
                addView = (UIImageView*)infoView;
                /*
                
                //productsCollectionView.userInteractionEnabled = NO;
                LixilBigDetailScrollView    *detailView = [[LixilBigDetailScrollView alloc] initWithFrame:CGRectMake(273, 85, self.view.frame.size.width-273, 629)];
                detailView.orientationType = ScrollorientationTypeVertical;
                detailView.arrayRBottomImage = @[[UIImage imageNamed:@"wooden_lt_page1.png"],[UIImage imageNamed:@"wooden_lt_page2.png"],[UIImage imageNamed:@"wooden_lt_page3.png"]];
                detailView.imageArray = @[[UIImage imageNamed:@"product_style.png"],[UIImage imageNamed:@"product_style2.png"],[UIImage imageNamed:@"product_style3.png"]];
                detailView.NeedDismiss = NO;
                
                addView = detailView;*/
            }
                break;
            case BottomImageViewBeginTag+4:
                addView = [[[NSBundle mainBundle] loadNibNamed:@"LixiCustomDizhiView" owner:self options:nil] lastObject];
                break;
            case BottomImageViewBeginTag+5:
            {
                //productsCollectionView.userInteractionEnabled = NO;
                LixilBigDetailScrollView    *detailView = [[LixilBigDetailScrollView alloc] initWithFrame:CGRectMake(273, 85, self.view.frame.size.width-273, 629)];
                detailView.orientationType = ScrollorientationTypeVertical;
                detailView.arrayRBottomImage = @[[UIImage imageNamed:@"wooden_lt_page1.png"],[UIImage imageNamed:@"wooden_lt_page2.png"],[UIImage imageNamed:@"wooden_lt_page3.png"]];
                detailView.imageArray = @[[UIImage imageNamed:@"product_wujin1.png"],[UIImage imageNamed:@"product_wujin2.png"],[UIImage imageNamed:@"product_wujin3.png"]];
                detailView.NeedDismiss = NO;
                
                addView = detailView;
            }
                break;
                
            default:
                break;
        }
        
    }else if (m_iCurrentType == JFProductsTypeKaifeili)
    {
        switch (tag)
        {
            case BottomImageViewBeginTag+3:
            {
                //productsCollectionView.userInteractionEnabled = NO;
                LixilBigDetailScrollView    *detailView = [[LixilBigDetailScrollView alloc] initWithFrame:CGRectMake(273, 85, self.view.frame.size.width-273, 629)];
                detailView.orientationType = ScrollorientationTypeVertical;
                detailView.imageArray = @[[UIImage imageNamed:@"kangfeili_peijian1.png"],[UIImage imageNamed:@"kangfeili_peijian2.png"]];
                detailView.arrayRBottomImage = @[[UIImage imageNamed:@"inax_lt_page21.png"],[UIImage imageNamed:@"inax_lt_page22.png"]];
                detailView.NeedDismiss = NO;
                // [detailView setShowBigImage:[UIImage imageNamed:@"kangfeili_peijian.png"] orientation:ScrollorientationTypeVertical];
                addView = detailView;
            }
                
                break;
            case BottomImageViewBeginTag+2:
                //kangfeili_shineishicai
                addView = [[UIImageView alloc] initWithFrame:CGRectMake(273, 85, 0, 629)];
                addView.image = [UIImage imageNamed:@"kangfeili_shineishicai.png"];
                break;
            case BottomImageViewBeginTag+1:
                addView = [[UIImageView alloc] initWithFrame:CGRectMake(273, 85, 0, 629)];
                addView.image = [UIImage imageNamed:@"kang_li_xilie.png"];
                break;
            default:
                break;
        }
        
    }else if (m_iCurrentType == JFProductsTypeLinaiduo)
    {
        switch (tag)
        {
            case BottomImageViewBeginTag+3:
            {
                //productsCollectionView.userInteractionEnabled = NO;
                LixilBigDetailScrollView    *detailView = [[LixilBigDetailScrollView alloc] initWithFrame:CGRectMake(273, 85, self.view.frame.size.width-273, 629)];
                detailView.orientationType = ScrollorientationTypeVertical;
                detailView.imageArray = @[[UIImage imageNamed:@"linaiduo_peijian1.png"]];
                detailView.NeedDismiss = NO;
                
                addView = detailView;
            }
                
                break;
            case BottomImageViewBeginTag+2:
                addView = [[UIImageView alloc] initWithFrame:CGRectMake(273, 85, 0, 629)];
                addView.image = [UIImage imageNamed:@"linaiduo_shineishicai.png"];
                break;
            case BottomImageViewBeginTag+1:
                addView = [[UIImageView alloc] initWithFrame:CGRectMake(273, 85, 0, 629)];
                addView.image = [UIImage imageNamed:@"kang_li_xilie.png"];
                break;
            default:
                break;
        }
        
    }
    
    if (tag == BottomImageViewBeginTag)
    {
        productsCollectionView.userInteractionEnabled = YES;
    }else
    {
        productsCollectionView.userInteractionEnabled = NO;
    }
    
    
    [addView setFrame:CGRectMake(273, 85, self.view.frame.size.width-273, 629)];
    if (addView)
    {
        [self.view addSubview:addView];
        if (isWholeBoby)
        {   //一体化界面动画
            LiXiWoodenWholeBodyView *bodyView = (LiXiWoodenWholeBodyView*)addView;
            [bodyView startAni];
        }
        addView.tag = ADDVIEWTAG;
    }
    //  [sender setBackgroundColor:mRGBColor(22, 22, 22)];
    debugLog(@"clickDetailBtn:%@",sender);
}


#pragma mark LixilWoodenproductSyleViewdelegate

-(void)clickWithProductCode:(NSString*)strCode
{
    Tproduct *product = nil;
    
    for (Tproduct *tempInfo in self.productsArray)
    {
        if ([tempInfo.code isEqualToString:strCode])
        {
            product = tempInfo;
            
        }
    }
    
    LixilProductDetailView *pdv = [LixilProductDetailView new];
    pdv.productid = product.productid;
    
    [self.navigationController pushViewController:pdv animated:NO];
    
    return;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"self.code match %@",strCode];
    NSArray *arrayCode = [self.productsArray filteredArrayUsingPredicate:pre];
    if (arrayCode.count)
    {
        
       // Tproduct *product = [arrayCode firstObject];//[self.productsArray objectAtIndex:indexPath.row];
        
        //NSLog(@"product name : %@",product.name);
        
        LixilProductDetailView *pdv = [LixilProductDetailView new];
        pdv.productid = product.productid;
        
        [self.navigationController pushViewController:pdv animated:NO];
        debugLog(@"count:%d",arrayCode.count);
    }
    
}


@end
