//
//  ProfileViewContainerTableViewCell.h
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/25.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileView.h"

@interface ProfileViewContainerTableViewCell : UITableViewCell
@property (weak, nonatomic, readonly) ProfileView *profileView;

- (void)addProfileView:(ProfileView *)profileView;
@end
