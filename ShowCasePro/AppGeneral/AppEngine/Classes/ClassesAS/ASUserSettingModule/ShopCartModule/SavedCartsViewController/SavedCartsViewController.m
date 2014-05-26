//
//  SavedCartsViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-10.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SavedCartsViewController.h"
#import "SavedCartsTableViewCell.h"
#import "Torder.h"
#import "GenericDao+Torder.h"

#define SavedCartsTableViewCellIdentifier @"SavedCartsTableViewCellIdentifier"

@interface SavedCartsViewController () <UITableViewDataSource, UITableViewDelegate, SavedCartsTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *savedCartsTableView;
@property (strong, nonatomic) NSArray *savedCartsArray;

@end

@implementation SavedCartsViewController

#pragma mark - SavedCartsTableViewCellDelegate

- (void)pleaseRemoveSavedCartInCell:(SavedCartsTableViewCell *)cell
{
    [UIAlertView showWithTitle:@"警告"
                       message:@"确认要删除吗（不可恢复）"
             cancelButtonTitle:@"取消"
             otherButtonTitles:@[@"确定"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1) {
                              int index = [self.savedCartsTableView indexPathForCell:cell].row;
                              GenericDao *orderDAO = [[GenericDao alloc] initWithClassName:@"Torder"];
                              if ([orderDAO deleteCartByOrderID:((Torder *)self.savedCartsArray[index]).torderid]) {
                                  [UIAlertView showAlertViewWithTitle:@"消息" message:@"删除成功"];
                                  [self initData];
                                  [self.savedCartsTableView reloadData];
                              } else {
                                  [UIAlertView showAlertViewWithTitle:@"消息" message:@"删除失败"];
                              }
                          }
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectedSavedCart:)]) {
        [self.delegate didSelectedSavedCart:self.savedCartsArray[indexPath.row]];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.savedCartsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SavedCartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SavedCartsTableViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    Torder *order = self.savedCartsArray[indexPath.row];
    cell.dateText.text = order.update_time;
    if (![order.remark equals:@""] && ![order.remark isEqual:[NSNull null]]) {
        cell.remarkText.text = order.remark;
    } else {
        cell.remarkText.text = @"您什么都没留下";
    }
    return cell;
}

#pragma mark - Init

- (void)initData
{
    GenericDao *orderDAO = [[GenericDao alloc] initWithClassName:@"Torder"];
    // 检索当前用户下所存储的所有购物车
    NSArray *arr = [orderDAO selectObjectsBy:@"userid" withValue:[LibraryAPI sharedInstance].currentUser.userid];
    self.savedCartsArray = arr;
}

- (void)initTableView
{
    [self.savedCartsTableView registerNib:[UINib nibWithNibName:@"SavedCartsTableViewCell" bundle:nil] forCellReuseIdentifier:SavedCartsTableViewCellIdentifier];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
