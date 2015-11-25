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

static CGFloat const kFireDistance = 126.0f;
static CGFloat const kProfileViewHeight = 377.0f;

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
    self.fixedContentsView.clipsToBounds = YES;
    self.fixedHeaderView.clipsToBounds = YES;
    self.profileView = [ProfileView profileView];
    self.profileView.clipsToBounds = YES;
    self.profileView.tag = 10000;

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
    if (self.profileView.superview == self.fixedHeaderView) {
        // header
    }
    else if (self.profileView.superview == self.fixedContentsView) {
        // topview
    }
    else {
        // cell
        [self.profileView removeFromSuperview];
        
        CGRect frame = self.profileView.frame;
        frame.origin.y = 0.0f;
        self.profileView.frame = frame;
        
        [self.fixedContentsView addSubview:self.profileView];
        self.fixedContentsView.hidden = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.profileView.superview == self.fixedHeaderView) {
        //　header
    }
    else if (self.profileView.superview == self.fixedContentsView) {
        // topview
        [self.profileView removeFromSuperview];
        
        CGRect frame = self.profileView.frame;
        frame.origin.y = (kProfileViewHeight - self.profileView.frame.size.height);
        self.profileView.frame = frame;
        
        [self.viewContollers[self.currentIndex].profileViewContainerTableViewCell addProfileView:self.profileView];
        self.fixedContentsView.hidden =  YES;
    }
    else {
        // cell
    }
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell {
    
    ProfileViewContainerTableViewCell *profileViewContainerTableViewCell =(ProfileViewContainerTableViewCell *)cell;
    
    [self.profileView removeFromSuperview];
    [profileViewContainerTableViewCell addProfileView:self.profileView];
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.profileView.superview == self.fixedHeaderView) {
        // スクロールがヘッダの固定位置より小さくなった時
        if (scrollView.contentOffset.y < kProfileViewHeight - kFireDistance) {
            // profileView in tableview　cell
            CGRect profileViewFrame = self.profileView.frame;
            profileViewFrame.size.height = kProfileViewHeight - (scrollView.contentOffset.y);
            profileViewFrame.origin.y = (scrollView.contentOffset.y);
            self.profileView.frame = profileViewFrame;
            
            self.profileView.profileContainerTopConstraint.constant = - (scrollView.contentOffset.y  * 0.5);
            [self.profileView layoutIfNeeded];
            
            [self.profileView removeFromSuperview];
            [viewController.profileViewContainerTableViewCell addProfileView:self.profileView];
            NSLog(@"セルに入れる");
        } else {
           // NSLog(@"ヘッダ内で動いてる");
        }
    } else if (self.profileView.superview == self.fixedContentsView) {
        
        NSLog(@"ありえないはず");
    }
    else {
        // スクロールがヘッダの固定位置に達した時
        if (scrollView.contentOffset.y < kProfileViewHeight - kFireDistance) {
            // profileView in tableview　cell
            CGRect profileViewFrame = self.profileView.frame;
            profileViewFrame.size.height = kProfileViewHeight - (scrollView.contentOffset.y);
            profileViewFrame.origin.y = (scrollView.contentOffset.y);
            self.profileView.frame = profileViewFrame;
            
            self.profileView.profileContainerTopConstraint.constant = - (scrollView.contentOffset.y  * 0.5);
            [self.profileView layoutIfNeeded];
             NSLog(@"セル内で動いてる");
        } else {
            CGRect frame = self.profileView.frame;
            frame.origin.y = 0.0f;
            self.profileView.frame = frame;
            
            [self.profileView removeFromSuperview];
            [self.fixedHeaderView addSubview:self.profileView];
            NSLog(@"ヘッダに入れる");
            
        }
    }
    
    if ([self.profileView.superview.superview isMemberOfClass:[self class]]) {
        
    }
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setContentOffsetWithTableViewController:viewController scrollView:scrollView];
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setContentOffsetWithTableViewController:viewController scrollView:scrollView];
}

- (void)setContentOffsetWithTableViewController:(ProfileTableViewController *)viewController scrollView:(UIScrollView *)scrollView {
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
