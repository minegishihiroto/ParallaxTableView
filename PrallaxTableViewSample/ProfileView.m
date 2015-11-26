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
    
    profileView.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return profileView;
}

- (IBAction)didTapFollowButton:(id)sender {
    NSLog(@"フォローする!!!");
}

- (IBAction)didTapTalkTabButton:(id)sender {
    UIButton *button = sender;
    [self.delegate profileView:self didTapTalkTabButton:button];
}

- (IBAction)didTapFollowerTabButton:(id)sender {
    UIButton *button = sender;
    [self.delegate profileView:self didTapFollowerTabButton:button];
}

- (IBAction)didTapFollowTabButton:(id)sender {
    UIButton *button = sender;
    [self.delegate profileView:self didTapFollowTabButton:button];
}
@end
