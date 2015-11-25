//
//  ProfileViewContainerTableViewCell.m
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/25.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import "ProfileViewContainerTableViewCell.h"

@interface ProfileViewContainerTableViewCell()
@property (weak, nonatomic, readwrite) ProfileView *profileView;
@end

@implementation ProfileViewContainerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addProfileView:(ProfileView *)profileView {
    self.profileView = profileView;
    [self.contentView addSubview:self.profileView];
}

@end
