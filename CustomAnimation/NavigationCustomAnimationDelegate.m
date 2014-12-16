//
//  UINavigation+CustomAnimation.m
//  CustomAnimation
//
//  Created by zhangnan on 14/12/9.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import "NavigationCustomAnimationDelegate.h"
#import "CustomAnimator.h"

@interface NavigationCustomAnimationDelegate ()
@property(nonatomic,strong) CustomAnimator* animator;
@end

@implementation NavigationCustomAnimationDelegate

- (instancetype)init
{
    if (self = [super init]) {
        _animator = [[CustomAnimator alloc]init];
    }
    
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush
        || operation == UINavigationControllerOperationPop) {
        return self.animator;
    }
    
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return self.interactionController;
}

- (void)setRotateImage:(UIImage*)image
{
    self.animator.rotateImg = image;
}
@end
