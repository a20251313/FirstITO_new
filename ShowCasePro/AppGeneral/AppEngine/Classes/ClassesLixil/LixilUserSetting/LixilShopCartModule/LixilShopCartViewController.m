//
//  CartViewController.m
//  CartDemo
//
//  Created by SUNMAC on 13-11-19.
//  Copyright (c) 2013年 lvpw. All rights reserved.
//
#define kDuihaoView 1
#define kGoodImageView 2
#define kGoodName 3
#define kBigKuang 4
#define kGoodPrice 5
#define kGoodCount 6

#import "LixilShopCartViewController.h"
#import "Cart.h"
#import "CartItem.h"
#import "Torder.h"
#import "TorderItem.h"
#import "Tproduct.h"
#import "NumberPad.h"
#import "Category.h"
#import "MacroDefine.h"
#import "LibraryAPI.h"
#import "GenericDao+Torder.h"
#import "SavedCartsViewController.h"
#import "CartViewCell.h"
#import "LixilProductDetailView.h"


@interface LixilShopCartViewController () <UITableViewDataSource, UITableViewDelegate, NumberPadDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIPopoverControllerDelegate, SavedCartsViewControllerDelegate, CartViewCellDelegate>

@property (nonatomic) BOOL isAllSelected;
@property (nonatomic, strong) UIPopoverController *shopCartPopoverController;

@end

@implementation LixilShopCartViewController

#pragma mark - CartViewCellDelegate

- (void)tiaozhuanProduct:(CartViewCell *)cell
{
    NSIndexPath *indexPath = [self.cartTableView indexPathForCell:cell];
    CartItem *item = [self cartItemAtIndexPath:indexPath];
    LixilProductDetailView *detailView = [[LixilProductDetailView alloc]init];
    detailView.productid = item.good.productid;
    [self.navigationController pushViewController:detailView animated:NO];
}

#pragma mark - SavedCartsViewControllerDelegate

- (void)didSelectedSavedCart:(Torder *)order
{
    [[Cart sharedInstance] clear];
    [Cart sharedInstance].totalPrice = order.totalprice;
    [Cart sharedInstance].goodsSize = order.goodssize;
    GenericDao *orderItemDAO = [[GenericDao alloc] initWithClassName:@"TorderItem"];
    NSArray *items = [orderItemDAO selectObjectsBy:@"torderid" withValue:[NSString stringWithFormat:@"%d", order.torderid]];
    NSMutableDictionary *cart = [NSMutableDictionary dictionary];
    NSMutableArray *goodIDs = [NSMutableArray array];
    GenericDao *productDAO = [[GenericDao alloc] initWithClassName:@"Tproduct"];
    for (TorderItem *orderItem in items) {
        CartItem *cartItem = [[CartItem alloc] init];
        cartItem.subPrice = orderItem.subprice;
        cartItem.subPriceUnit = orderItem.subpriceunit;
        cartItem.subQuentity = orderItem.subquentity;
        cartItem.good = (Tproduct *)[productDAO selectObjectsBy:@"productid" withValue:orderItem.productid options:@{@"productid": @"id"}][0];
        [cart setObject:cartItem forKey:orderItem.productid];
        [goodIDs addObject:orderItem.productid];
    }
    [Cart sharedInstance].cart = cart;
    [Cart sharedInstance].goodsIDs = goodIDs;
    
    [self.cartTableView reloadData];
    [self changeUI];
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.shopCartPopoverController = nil;
//    [popoverController dismissPopoverAnimated:YES];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@"0.0"]) {
        textField.text = @"";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 判断是否为数字、回退和'.'
    if (!([string isEqualToString:@"1"] || [string isEqualToString:@"2"] || [string isEqualToString:@"4"] || [string isEqualToString:@"3"] || [string isEqualToString:@"5"] || [string isEqualToString:@"6"] || [string isEqualToString:@"7"] || [string isEqualToString:@"8"] || [string isEqualToString:@"9"] || [string isEqualToString:@"0"] || [string isEqualToString:@"."] || [string isEqualToString:@""])) {
        return NO;
    }
    NSString *end = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *array = [end componentsSeparatedByString:@"."];
    if ([array count] < 2) {
        if (((NSString *)[array objectAtIndex:0]).length <= 5) return YES;
        else return NO;
    } else if([array count] == 2){
        if (((NSString *)[array objectAtIndex:0]).length <= 5 && ((NSString *)[array objectAtIndex:1]).length <= 2) return YES;
        else return NO;
    } else return NO;
}

#pragma mark - NumberPadDelegate

- (void)stringChanged:(NSString *)string
{
    _discount.text = string;
    [self updatePrice];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[Cart sharedInstance].goodsIDs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CartViewCell";
    CartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CartViewCell" owner:self options:nil];
        if ([nib count] > 0) {
            cell = [nib objectAtIndex:0];
        }
        cell.delegate = self;
    }
    CartItem *item = [self cartItemAtIndexPath:indexPath];
//    ((UIImageView *)[cell viewWithTag:kGoodImageView]).image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", kLibrary, item.good.image1]];
    ((UIImageView *)[cell viewWithTag:kGoodImageView]).image = [[LibraryAPI sharedInstance] getImageFromPath:item.good.image1 scale:16];
    ((UILabel *)[cell viewWithTag:kGoodName]).text = item.good.name;
    ((UITextField *)[cell viewWithTag:kGoodPrice]).text = [NSString stringWithFormat:@"%.1f",item.subPriceUnit];
    ((UILabel *)[cell viewWithTag:kGoodCount]).text = [NSString stringWithFormat:@"%d", item.subQuentity];
    ((UIImageView *)[cell viewWithTag:kDuihaoView]).hidden = item.duihaoStatus;
    return cell;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        Torder *order = [Torder new];
        order.remark = [alertView textFieldAtIndex:0].text;
        order.update_time = [[LibraryAPI sharedInstance] NSDateToStringByFormatter:@"yyyy-MM-dd HH:mm:ss"];
        order.create_time = [[LibraryAPI sharedInstance] NSDateToStringByFormatter:@"yyyy-MM-dd HH:mm:ss"];
        order.totalprice = [Cart sharedInstance].totalPrice;
        order.goodssize = [Cart sharedInstance].goodsSize;
        order.userid = [LibraryAPI sharedInstance].currentUser.userid;
        
        NSMutableArray *items = [NSMutableArray array];
        
        for (NSString *productid in [Cart sharedInstance].goodsIDs) {
            TorderItem *orderItem = [TorderItem new];
            orderItem.productid = productid;
            CartItem *item = [[Cart sharedInstance].cart objectForKey:productid];
            orderItem.subquentity = item.subQuentity;
            orderItem.subpriceunit = item.subPriceUnit;
            orderItem.subprice = item.subPrice;
            [items addObject:orderItem];
        }
        
        GenericDao *orderDAO = [[GenericDao alloc] initWithClassName:@"Torder"];
        BOOL b = [orderDAO saveCartToOrderByOrder:order andItems:items];
        if (b) {
            [UIAlertView showAlertViewWithTitle:@"结果" message:@"暂存成功"];
            // 清空购物车
            [[Cart sharedInstance] clear];
            // 刷新UI
            [self.cartTableView reloadData];
            [self changeUI];
//            self.cartTableView.hidden = YES;
//            self.emptyImageView.hidden = NO;
        } else {
            [UIAlertView showAlertViewWithTitle:@"结果" message:@"暂存失败"];
        }
    }
}

#pragma mark - Handle Action

- (IBAction)clearCart:(id)sender {
    [[Cart sharedInstance] clear];
    [self.cartTableView reloadData];
    [self changeUI];
//    [self updatePrice];
}

- (IBAction)showSavedCarts:(UIButton *)sender
{
    SavedCartsViewController *savedCartsViewController = [[SavedCartsViewController alloc] initWithNibName:@"SavedCartsViewController" bundle:nil];
    savedCartsViewController.delegate = self;
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:savedCartsViewController];
    self.shopCartPopoverController = popoverController;
    popoverController.delegate = self;
    popoverController.backgroundColor = [UIColor colorWithWhite:0.129 alpha:1.000];
    popoverController.popoverContentSize = savedCartsViewController.view.frame.size;
    [popoverController presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)saveCart:(id)sender
{
    if (![Cart sharedInstance].goodsSize) {
        [UIAlertView showAlertViewWithTitle:@"错误操作" message:@"购物车为空，请添加产品！"];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"暂存购物车产品"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"暂存", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView textFieldAtIndex:0].placeholder = @"请输入备注";
        [alertView show];
    }
}

- (IBAction)deleteCartItem:(id)sender event:(id)event
{
    [UIAlertView showWithTitle:@"你确定要删除选中的物品吗?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            UITableViewCell *cell = [_cartTableView cellForRowAtIndexPath:[_cartTableView indexPathForRowAtPoint:[[[event allTouches]anyObject] locationInView:_cartTableView]]];
            int row = [_cartTableView indexPathForCell:cell].row;
            NSString *pid = [[Cart sharedInstance].goodsIDs objectAtIndex:row];
            [[Cart sharedInstance] cutByPid:pid type:@"all"];
            [_cartTableView reloadData];
            [self updatePrice];
        }
    }];
}

- (IBAction)changePrice:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)[[[sender superview]superview]superview];
    CartItem *item = [self cartItemAtIndexPath:[_cartTableView indexPathForCell:cell]];
    item.subPriceUnit = [[NSString stringWithFormat:@"%.1f", [((UITextField *)sender).text doubleValue]] doubleValue];
    ((UITextField *)sender).text = [NSString stringWithFormat:@"%.1f", item.subPriceUnit];
    [self updatePrice];
}

- (IBAction)cutQuantity:(id)sender event:(id)event
{
    UITableViewCell *cell = [_cartTableView cellForRowAtIndexPath:[_cartTableView indexPathForRowAtPoint:[[[event allTouches]anyObject] locationInView:_cartTableView]]];
    int row = [_cartTableView indexPathForCell:cell].row;
    NSString *pid = [[Cart sharedInstance].goodsIDs objectAtIndex:row];
    [[Cart sharedInstance] cutByPid:pid type:@"single"];
    [_cartTableView reloadData];
    [self updatePrice];
}

- (IBAction)addQuantity:(id)sender event:(id)event
{
    UITableViewCell *cell = [_cartTableView cellForRowAtIndexPath:[_cartTableView indexPathForRowAtPoint:[[[event allTouches]anyObject] locationInView:_cartTableView]]];
    int row = [_cartTableView indexPathForCell:cell].row;
    NSString *pid = [[Cart sharedInstance].goodsIDs objectAtIndex:row];
    [[Cart sharedInstance] addByPid:pid];
    [_cartTableView reloadData];
    [self updatePrice];
}

- (IBAction)ShowOrHideDuihao:(id)sender event:(id)event
{
    UITableViewCell *cell = [_cartTableView cellForRowAtIndexPath:[_cartTableView indexPathForRowAtPoint:[[[event allTouches]anyObject] locationInView:_cartTableView]]];
    [self cartItemAtIndexPath:[_cartTableView indexPathForCell:cell]].duihaoStatus =  [self HandleDuihao:cell];
}

- (IBAction)ChooseOrCancleAllDuihao:(id)sender
{
    BOOL status = _isAllSelected;
    UITableViewCell *cell = nil;
    for (int i = 0; i < [_cartTableView numberOfRowsInSection:0]; i++) {
        cell = [_cartTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell viewWithTag:kDuihaoView].hidden = status;
        [self cartItemAtIndexPath:[_cartTableView indexPathForCell:cell]].duihaoStatus = status;
    }
    _isAllSelected = !_isAllSelected;
}

- (void)deleteChooseGoods:(UIGestureRecognizer *)recognizer
{
    NSMutableArray *goosIDNeedRemove = [NSMutableArray array];
    for (int i = 0; i < [[Cart sharedInstance].goodsIDs count]; i++) {
        NSString *goodId = [[Cart sharedInstance].goodsIDs objectAtIndex:i];
        CartItem *item = [[Cart sharedInstance].cart objectForKey:goodId];
        if (!item.duihaoStatus) {
            [goosIDNeedRemove addObject:goodId];
        }
    }
    if ([goosIDNeedRemove count] <= 0) {
        [UIAlertView showAlertViewWithTitle:@"您没有选中任何商品" message:@"无商品"];
        return;
    }
    [UIAlertView showWithTitle:@"你确定要删除选中的物品吗?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[Cart sharedInstance].cart removeObjectsForKeys:goosIDNeedRemove];
            [[Cart sharedInstance].goodsIDs removeObjectsInArray:goosIDNeedRemove];
            [_cartTableView reloadData];
            _duihao.hidden = YES;
            [self updatePrice];
        }
    }];
}

#pragma mark - Utility

- (void)changeUI
{
    if ([[Cart sharedInstance].goodsIDs count] == 0 ) {
        self.cartTableView.hidden = YES;
        self.emptyImageView.hidden = NO;
    } else {
        self.cartTableView.hidden = NO;
        self.emptyImageView.hidden = YES;
    }
    [self updatePrice];
}

- (void)reloadCartTableView:(NSNotification *)notification
{
    [self.cartTableView reloadData];
}

- (CartItem *)cartItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *goodId = [[Cart sharedInstance].goodsIDs objectAtIndex:indexPath.row];
    CartItem *item = [[Cart sharedInstance].cart objectForKey:goodId];
    return item;
}

- (BOOL)HandleDuihao:(UIView *)view
{
    UIImageView *duihao = (UIImageView *)[view viewWithTag:kDuihaoView];
    duihao.hidden = !duihao.hidden;
    return duihao.hidden;
}

- (void)updatePrice
{
    double totalPrice = [Cart sharedInstance].totalPrice;
    double discountPrice = totalPrice*(100-[_discount.text doubleValue])/100;
    double endPrice = totalPrice - discountPrice;
    _totalPrice.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
    _discountPrice.text = [NSString stringWithFormat:@"￥%.2f", discountPrice];
    _endPrice.text = [NSString stringWithFormat:@"￥%.2f", endPrice];
}

#pragma mark - Init

- (void)initNumberPadView
{
    NumberPad *numberPad = [[NumberPad alloc]initWithNibName:@"NumberPad" bundle:nil];
    numberPad.delegate = self;
    numberPad.view.frame = (CGRect){.origin=CGPointMake(0, 15), .size=numberPad.view.frame.size};
    [_numberPadView addSubview:numberPad.view];
    [self addChildViewController:numberPad];
}

- (void)initDeleteChooseGoods
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteChooseGoods:)];
    [_deleteChooseGoods addGestureRecognizer:tap];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self initCart];
    
//    [self initNumberPadView];
    
    [self updatePrice];
    
    [self initDeleteChooseGoods];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCartTableView:) name:@"GoodsInCartChanged" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeUI];
//    if ([[Cart sharedInstance].goodsIDs count] == 0 ) {
//        self.cartTableView.hidden = YES;
//        self.emptyImageView.hidden = NO;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
