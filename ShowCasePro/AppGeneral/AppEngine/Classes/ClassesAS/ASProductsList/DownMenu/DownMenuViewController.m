//
//  DownMenuViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "DownMenuViewController.h"
#import "DownMenuCell.h"
#import "ObjectBase.h"

#define DownMenuCellIdentifier @"DownMenuCellIdentifier"

@interface DownMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic) CGRect changeToFrame;

@end

@implementation DownMenuViewController

#pragma mark - Handle Action

- (IBAction)tapBGView:(id)sender {
    [self dismiss];
}

- (void)showFromView:(UIView *)subView inView:(UIView *)view animated:(BOOL)animated
{
    [self.tableview setSeparatorColor:self.color];
    CGRect endRect = [subView.superview convertRect:subView.frame toView:view];
    if (self.dataArray.count<11) {
        self.view.frame = (CGRect){.origin=CGPointMake(endRect.origin.x-20, endRect.origin.y+endRect.size.height), .size=CGSizeMake(150, 33*self.dataArray.count)};
        ((UIImageView *)[self.view viewWithTag:33]).frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+3);
    } else {
        self.view.frame = (CGRect){.origin=CGPointMake(endRect.origin.x-20, endRect.origin.y+endRect.size.height), .size=CGSizeMake(150, 363)};
        ((UIImageView *)[self.view viewWithTag:33]).frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+3);
    }
    [self.tableview reloadData];
    [view addSubview:self.view];
    
    _show = YES;
}

- (void)dismiss
{
    self.show = NO;
    [self.view removeFromSuperview];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(downMenu:DidSeletedAtIndex:)]) {
        [self.delegate downMenu:self DidSeletedAtIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:DownMenuCellIdentifier forIndexPath:indexPath];
    ObjectBase *baseObj = self.dataArray[indexPath.row];
    cell.label.text = baseObj.name;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Init

- (void)initTableView
{
    [self.tableview registerNib:[UINib nibWithNibName:@"DownMenuCell" bundle:nil] forCellReuseIdentifier:DownMenuCellIdentifier];
    [self.tableview setSeparatorColor:self.color];
}

#pragma mark - Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
