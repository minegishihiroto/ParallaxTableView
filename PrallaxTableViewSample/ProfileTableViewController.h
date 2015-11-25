//
//  ProfileTableViewController.h
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/24.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewContainerTableViewCell.h"

@protocol ProfileTableViewControllerDelegatge;
@interface ProfileTableViewController : UIViewController

@property (weak, nonatomic) id <ProfileTableViewControllerDelegatge> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic, readonly) ProfileViewContainerTableViewCell *profileViewContainerTableViewCell;

@end

@protocol ProfileTableViewControllerDelegatge <NSObject>

- (void)profileTableViewController: (ProfileTableViewController *)viewController tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell;

- (void)profileTableViewController: (ProfileTableViewController *)viewController scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)profileTableViewController: (ProfileTableViewController *)viewController scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)profileTableViewController: (ProfileTableViewController *)viewController scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


@end