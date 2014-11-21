//
//  ViewController.m
//  Pages
//
//  Created by mysoft on 11/19/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import "RootViewController.h"
#import "PhotosViewController.h"

@interface RootViewController ()
{
    NSArray *tableArray;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableArray = @[@"分页效果"];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    
    [_tabelView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PhotosViewController *photoCtr = [[PhotosViewController alloc] init];
        [self.navigationController pushViewController:photoCtr animated:YES];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identityStr = @"cellIdentifier";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identityStr];
    cell.textLabel.text = [tableArray objectAtIndex:indexPath.row];
    return cell;
}

@end
