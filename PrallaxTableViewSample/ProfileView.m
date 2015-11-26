//
//  ProfileView.m
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/25.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import "ProfileView.h"

@implementation ProfileView

+ (ProfileView *)profileView {
    ProfileView *profileView = [[[NSBundle mainBundle] loadNibNamed:@"ProfileView" owner:nil options:nil] lastObject];
    
   // profileView.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return profileView;
}

- (void)setUpIndicatorView {
    CGFloat viewWidth = self.frame.size.width;
    self.indicatorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 62, viewWidth, 2)];
    self.indicatorScrollView.backgroundColor = [UIColor clearColor];
    self.indicatorScrollView.contentOffset = CGPointMake(0, 0);
    self.indicatorScrollView.contentSize = CGSizeMake(viewWidth, 0);
    [self.tabContainerView addSubview:self.indicatorScrollView];
    
    for (int i = 0; i < 3; i ++) {
        UIView *indicatorBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(i * (viewWidth / 3), 0, viewWidth / 3, 2)];
        if (i == 0) {
            indicatorBackgroundView.backgroundColor = [UIColor redColor];
        }
        [self.indicatorScrollView addSubview:indicatorBackgroundView];
    }
    
}

- (IBAction)didTapFollowButton:(id)sender {
    NSLog(@"フォローする!!!");
}

- (IBAction)didTapTalkTabButton:(id)sender {
    UIButton *button = sender;
    [self.delegate profileView:self didTapTalkTabButton:button];
    [self.indicatorScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)didTapFollowerTabButton:(id)sender {
    UIButton *button = sender;
    [self.delegate profileView:self didTapFollowerTabButton:button];
    [self.indicatorScrollView setContentOffset:CGPointMake(-(self.frame.size.width / 3), 0) animated:YES];
}

- (IBAction)didTapFollowTabButton:(id)sender {
    UIButton *button = sender;
    [self.delegate profileView:self didTapFollowTabButton:button];
    [self.indicatorScrollView setContentOffset:CGPointMake(-2 * (self.frame.size.width / 3), 0) animated:YES];
}
@end
