//
//  SlideViewController.m
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/24.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import "SlideViewController.h"
#import "ProfileTableViewController.h"

@interface SlideViewController () <UIScrollViewDelegate, ProfileTableViewControllerDelegatge>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *containerViews;
@property (copy, nonatomic) NSArray<ProfileTableViewController *> *viewContollers;
@property (strong, nonatomic) ProfileView *profileView;
@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGRect tableBounds = CGRectMake(0.0f, 50.f, width, height);
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounds = tableBounds; // scrollViewのページングをTABLE_WIDTH単位に。
    self.scrollView.clipsToBounds = NO;   // 非表示になっているtableBounds外を表示。
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *containerView in self.containerViews) {
        ProfileTableViewController *viewController = [[ProfileTableViewController alloc] init];
        viewController.delegate = self;
        [array addObject:viewController];
        viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [containerView addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    self.viewContollers = array;
    self.fixedHeaderView.clipsToBounds = YES;
    self.profileView = [ProfileView profileView];

    self.fixedContentsView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)currentIndex {
    return ((NSInteger)self.scrollView.contentOffset.x + 1) / (NSInteger)self.view.bounds.size.width;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.profileView.superview != self.fixedHeaderView) {
        [self.profileView removeFromSuperview];
        [self.fixedContentsView addSubview:self.profileView];
        self.fixedContentsView.hidden = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.profileView.superview == self.fixedContentsView) {
        
        [self.profileView removeFromSuperview];
        [self.viewContollers[self.currentIndex].profileViewContainerTableViewCell addProfileView:self.profileView];
        self.fixedContentsView.hidden =  YES;
    }
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell {
    
    ProfileViewContainerTableViewCell *profileViewContainerTableViewCell =(ProfileViewContainerTableViewCell *)cell;
    
    [self.profileView removeFromSuperview];
    [profileViewContainerTableViewCell addProfileView:self.profileView];
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.profileView.superview == self.fixedHeaderView) {
        if (scrollView.contentOffset.y < (CGRectGetHeight(self.profileView.frame) - CGRectGetHeight(self.fixedHeaderView.frame))) {
            // profileView in tableview　cell
            self.profileView.frame = CGRectMake(0, scrollView.contentOffset.y * 0.5, CGRectGetWidth(self.profileView.frame), CGRectGetHeight(self.profileView.frame));
            self.profileView.tabContainerViewBottomConstraint.constant = scrollView.contentOffset.y * 0.5;
            [self.profileView layoutIfNeeded];
            
            [self.profileView removeFromSuperview];
            [viewController.profileViewContainerTableViewCell addProfileView:self.profileView];
        }
    } else {
        // スクロールがヘッダの固定位置に達した時
        if (scrollView.contentOffset.y >= (CGRectGetHeight(self.profileView.frame) - CGRectGetHeight(self.fixedHeaderView.frame))) {
            [self.profileView removeFromSuperview];
            
            CGRect frame = self.profileView.frame;
            frame.origin.y = - ((CGRectGetHeight(self.profileView.frame) - CGRectGetHeight(self.fixedHeaderView.frame))) * 0.5;
            self.profileView.frame = frame;
            
            [self.fixedHeaderView addSubview:self.profileView];
        } else {
            // profileView in tableview　cell
            self.profileView.frame = CGRectMake(0, scrollView.contentOffset.y * 0.5, CGRectGetWidth(self.profileView.frame), CGRectGetHeight(self.profileView.frame));
            self.profileView.tabContainerViewBottomConstraint.constant = scrollView.contentOffset.y * 0.5;
            [self.profileView layoutIfNeeded];
        }
    }
    
    if ([self.profileView.superview.superview isMemberOfClass:[self class]]) {
        
    }
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.viewContollers[self.currentIndex] != viewController) {
        return;
    }
    
    for (ProfileTableViewController *viewController in self.viewContollers) {
        if (viewController.tableView == scrollView) {
            continue;
        }
        
        [viewController.tableView setContentOffset:scrollView.contentOffset animated:NO];
    }
}

@end
