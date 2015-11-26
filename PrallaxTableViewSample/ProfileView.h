//
//  ProfileView.h
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/25.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileViewDelegate;
@interface ProfileView : UIView

@property (weak, nonatomic) id<ProfileViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *profileContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIView *tabContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabContainerViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileContainerTopConstraint;
@property (strong, nonatomic) UIScrollView *indicatorScrollView;


+ (ProfileView *)profileView;
- (void)setUpIndicatorView;

@end

@protocol ProfileViewDelegate <NSObject>

- (void)profileView:(ProfileView *)view didTapFollowButton:(UIButton *)button;
- (void)profileView:(ProfileView *)view didTapTalkTabButton:(UIButton *)button;
- (void)profileView:(ProfileView *)view didTapFollowerTabButton:(UIButton *)button;
- (void)profileView:(ProfileView *)view didTapFollowTabButton:(UIButton *)button;

@end