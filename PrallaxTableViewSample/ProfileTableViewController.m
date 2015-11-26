//
//  ProfileTableViewController.m
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/24.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "FriendTableViewCell.h"

@interface ProfileTableViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (copy, nonatomic) NSArray *namesArray;
@property (copy, nonatomic) NSArray *photoNameArray;
@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.namesArray = @[@"Lauren Richard", @"Nicholas Ray", @"Kim White", @"Charles Gray", @"Timothy Jones", @"Sarah Underwood", @"William Pearl", @"Juan Rodriguez", @"Anna Hunt", @"Marie Turner", @"George Porter", @"Zachary Hecker", @"David Fletcher",@"Lauren Richard", @"Nicholas Ray", @"Kim White", @"Charles Gray", @"Timothy Jones", @"Sarah Underwood", @"William Pearl", @"Juan Rodriguez", @"Anna Hunt", @"Marie Turner", @"George Porter", @"Zachary Hecker", @"David Fletcher"];
    self.photoNameArray= @[@"woman5.jpg", @"man1.jpg", @"woman1.jpg", @"man2.jpg", @"man3.jpg", @"woman2.jpg", @"man4.jpg", @"man5.jpg", @"woman3.jpg", @"woman4.jpg", @"man6.jpg", @"man7.jpg", @"man8.jpg",@"woman5.jpg", @"man1.jpg", @"woman1.jpg", @"man2.jpg", @"man3.jpg", @"woman2.jpg", @"man4.jpg", @"man5.jpg", @"woman3.jpg", @"woman4.jpg", @"man6.jpg", @"man7.jpg", @"man8.jpg"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileViewContainerTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProfileViewContainerTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ProfileViewContainerTableViewCell *)profileViewContainerTableViewCell {
    return [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    return 26;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ProfileViewContainerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileViewContainerTableViewCell"];
        [self.delegate profileTableViewController:self tableView:tableView cellForRowAtIndexPath:indexPath cell:cell];
        return cell;
    }
    
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCell" forIndexPath:indexPath];
    cell.nameLabel.text = self.namesArray[indexPath.row];
    cell.photoImageView.image = [UIImage imageNamed:self.photoNameArray[indexPath.row]];
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 379;
    }
    return 64.0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate profileTableViewController:self scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.delegate profileTableViewController:self scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.delegate profileTableViewController:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.delegate profileTableViewController:self scrollViewDidEndDecelerating:scrollView];
}

@end
