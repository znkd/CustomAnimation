//
//  UINavigation+CustomAnimation.h
//  CustomAnimation
//
//  Created by zhangnan on 14/12/9.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NavigationCustomAnimationDelegate : NSObject <UINavigationControllerDelegate>
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition* interactionController;

- (void)setRotateImage:(UIImage*)image;
@end
