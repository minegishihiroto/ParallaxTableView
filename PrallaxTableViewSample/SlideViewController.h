//
//  SlideViewController.h
//  PrallaxTableViewSample
//
//  Created by A12712 on 2015/11/24.
//  Copyright © 2015年 A12712. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *fixedHeaderView;
@property (weak, nonatomic) IBOutlet UIView *fixedContentsView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@end
