//
//  ASMenuViewController.m
//  UIPopViewDemo
//
//  Created by lvpw on 14-2-13.
//  Copyright (c) 2014年 lvpw. All rights reserved.
//

#import "ASMenuViewController.h"
#import "ASMenuTableViewCell.h"

#define MenuTableViewCellIdentifier @"MenuTableViewCellIdentifier"
#define CellImageName @"CellImageName"
#define CellLabel @"CellLabel"
#define CellViewControllerName @"CellViewControllerName"

@interface ASMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *menuData;

@end

@implementation ASMenuViewController

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(asMenuViewControllerDidSelectedViewControllerName:)]) {
        [self.delegate asMenuViewControllerDidSelectedViewControllerName:self.menuData[indexPath.section][indexPath.row][CellViewControllerName]];
    }
    // 清除背景颜色
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menuData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.menuData[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuTableViewCellIdentifier forIndexPath:indexPath];
  //  cell.backgroundColor = [UIColor colorWithRed:64/255. green:64/255. blue:64/255. alpha:1];
     cell.backgroundColor = [UIColor clearColor];
   // cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    NSDictionary *dict = self.menuData[indexPath.section][indexPath.row];
    cell.menuCellLabel.text = dict[CellLabel];
    if (![dict[CellImageName] isEqualToString:@""]) {
        cell.menuCellImage.image = [UIImage imageNamed:dict[CellImageName]];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 5)];
    view.backgroundColor = [UIColor blackColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 1)];
    view.backgroundColor = [UIColor blackColor];
    if (section == 0) {
        view.backgroundColor = [UIColor colorWithRed:64/255. green:64/255. blue:64/255. alpha:1];
    }
    return view;
}

#pragma mark - Init

- (void)initData
{
    self.menuData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ASMenuTableViewData" ofType:@"plist"]];
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
    
    [self.menuTableView registerNib:[UINib nibWithNibName:@"ASMenuTableViewCell" bundle:nil] forCellReuseIdentifier:MenuTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
