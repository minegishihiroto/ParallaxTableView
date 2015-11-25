//
//  ProfileView.h
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/25.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIView *tabContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabContainerViewBottomConstraint;


+ (ProfileView *)profileView;

@end
