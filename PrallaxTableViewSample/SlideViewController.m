//
//  SlideViewController.m
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/24.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import "SlideViewController.h"
#import "ProfileTableViewController.h"

@interface SlideViewController () <UIScrollViewDelegate, ProfileTableViewControllerDelegatge, ProfileViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *containerViews;
@property (copy, nonatomic) NSArray<ProfileTableViewController *> *viewContollers;
@property (strong, nonatomic) ProfileView *profileView;

@end

@implementation SlideViewController

static CGFloat const kFireDistance = 128.0f;
static CGFloat const kProfileViewHeight = 379.0f;

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
    self.profileView.delegate = self;
    self.profileView.clipsToBounds = YES;
    
    self.fixedContentsView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.profileView setUpIndicatorView];
}

- (NSUInteger)currentIndex {
    return ((NSInteger)self.scrollView.contentOffset.x + 1) / (NSInteger)self.view.bounds.size.width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self addProfileViewToContentView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self removeProfiliViewFromContentView];
}

- (void)addProfileViewToContentView {
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
        self.fixedContentsView.hidden =  NO;
    }
}

- (void)removeProfiliViewFromContentView {
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
    
    if (self.viewContollers[self.currentIndex] != viewController) {
        return;
    }

    if (tableView.contentOffset.y < kProfileViewHeight - kFireDistance) {
        ProfileViewContainerTableViewCell *profileViewContainerTableViewCell =(ProfileViewContainerTableViewCell *)cell;
        [self.profileView removeFromSuperview];
        [profileViewContainerTableViewCell addProfileView:self.profileView];
    }
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setProfilViewWithTableViewController:viewController scrollView:scrollView];
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setContentOffsetWithTableViewController:viewController scrollView:scrollView];
}

- (void)profileTableViewController:(ProfileTableViewController *)viewController scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setContentOffsetWithTableViewController:viewController scrollView:scrollView];
}

- (void)setProfilViewWithTableViewController:(ProfileTableViewController *)viewController scrollView:(UIScrollView *)scrollView {
    if (self.profileView.superview.superview == viewController.profileViewContainerTableViewCell) {
        if (scrollView.contentOffset.y < 0) {
            CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 315);
            CGFloat delta = fabs(MIN(0.0f, scrollView.contentOffset.y));
            CGRect coverImageFrame = self.profileView.coverImageView.frame;
            coverImageFrame.origin.x = CGRectGetMinX(rect) - delta/2;
            coverImageFrame.origin.y = CGRectGetMinY(rect) - delta;
            coverImageFrame.size.width = CGRectGetWidth(rect) + delta;
            coverImageFrame.size.height = CGRectGetHeight(rect) + delta;
            self.profileView.coverImageView.frame = coverImageFrame;
        }
        // スクロールがヘッダの固定位置に達した時
        else if (scrollView.contentOffset.y < kProfileViewHeight - kFireDistance) {
            [self.profileView layoutIfNeeded];
            CGRect profileViewFrame = self.profileView.frame;
            profileViewFrame.size.height = kProfileViewHeight - (scrollView.contentOffset.y);
            profileViewFrame.origin.y = (scrollView.contentOffset.y);
            self.profileView.frame = profileViewFrame;
            
            self.profileView.profileContainerTopConstraint.constant = - (scrollView.contentOffset.y  * 0.5);
            [self.profileView layoutIfNeeded];
            NSLog(@"セル内で動いてる");
        }
        else if (scrollView.contentOffset.y > kProfileViewHeight - kFireDistance) {
            
            CGRect profileViewFrame = self.profileView.frame;
            profileViewFrame.origin.y = 0.0f;
            profileViewFrame.size.height = kFireDistance;
            self.profileView.frame = profileViewFrame;
            
            [self.profileView removeFromSuperview];
            [self.fixedHeaderView addSubview:self.profileView];
            NSLog(@"ヘッダに入れる");
        }
    }
    else if (self.profileView.superview == self.fixedHeaderView) {
        // スクロールがヘッダの固定位置より小さくなった時
        if (scrollView.contentOffset.y > kProfileViewHeight - kFireDistance) {
            NSLog(@"ヘッダ内で動いてる");
        }
        else if (scrollView.contentOffset.y < kProfileViewHeight - kFireDistance) {
            [self.profileView layoutIfNeeded];
            CGRect profileViewFrame = self.profileView.frame;
            profileViewFrame.size.height = kProfileViewHeight - (scrollView.contentOffset.y);
            profileViewFrame.origin.y = (scrollView.contentOffset.y);
            self.profileView.frame = profileViewFrame;
            
            self.profileView.profileContainerTopConstraint.constant = - (scrollView.contentOffset.y  * 0.5);
            [self.profileView layoutIfNeeded];
            
            [self.profileView removeFromSuperview];
            [viewController.profileViewContainerTableViewCell addProfileView:self.profileView];
            NSLog(@"セルに入れる");
        }
    } else if (self.profileView.superview == self.fixedContentsView) {
        
        NSLog(@"ありえないはず");
        [self removeProfiliViewFromContentView];
    }
}
                            

- (void)setContentOffsetWithTableViewController:(ProfileTableViewController *)viewController scrollView:(UIScrollView *)scrollView {
    if (self.viewContollers[self.currentIndex] != viewController) {
        return;
    }
    
    for (ProfileTableViewController *viewController in self.viewContollers) {
        if (viewController.tableView == scrollView) {
            continue;
        }
        CGPoint newOffset = scrollView.contentOffset;
        if (scrollView.contentOffset.y > kProfileViewHeight - kFireDistance) {
            NSLog(@"scrollview offset:%f", scrollView.contentOffset.y);
            newOffset.y = kProfileViewHeight - kFireDistance;
            
        }
        [viewController.tableView setContentOffset:newOffset animated:NO];
    }
}

#pragma mark ProfileViewDelegate
- (void)profileView:(ProfileView *)view didTapFollowButton:(UIButton *)button {
    
}
- (void)profileView:(ProfileView *)view didTapTalkTabButton:(UIButton *)button {
    [self addProfileViewToContentView];
    CGPoint offset = CGPointMake(0, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}
- (void)profileView:(ProfileView *)view didTapFollowerTabButton:(UIButton *)button {
    [self addProfileViewToContentView];
    CGPoint offset = CGPointMake(self.view.bounds.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}
- (void)profileView:(ProfileView *)view didTapFollowTabButton:(UIButton *)button {
    [self addProfileViewToContentView];
    CGPoint offset = CGPointMake(self.view.bounds.size.width * 2, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

@end
