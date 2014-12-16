//
//  CustomAnimator.m
//  CustomAnimation
//
//  Created by zhangnan on 14/12/9.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import "CustomAnimator.h"

static const int FourClip_Big_Width = 59;
static const int FourClip_Small_Width = 40;
static const int ThreeBlank_Big_Width = 47;
static const int ThreeBlank_Small_Width = 28;

@implementation CustomAnimator


#pragma UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    
//    switch (_animatorType) {
//        case ANIMATOR_TYPE_INTERACTION:
//        {
#if 1
            toVC.view.alpha = .0f;
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                fromVC.view.alpha = 0.0;
                toVC.view.alpha = 1.0;
            }completion:^(BOOL finished){
                fromVC.view.alpha = 1.0;
                toVC.view.alpha = 1.0;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
#else
            fromVC.view.alpha = 0.0;
            toVC.view.alpha = .0f;
            
            NSArray* imgArr = [self clip4Img];
    
            CALayer* layer1st = [CALayer layer];
            layer1st.frame = (CGRect){0,0,((UIImage*)imgArr[0]).size};
            layer1st.contents = (id)((UIImage*)imgArr[0]).CGImage;
            
            CALayer* layer2nd = [CALayer layer];
            layer2nd.frame = (CGRect){81,0,((UIImage*)imgArr[1]).size};
            layer2nd.contents = (id)((UIImage*)imgArr[1]).CGImage;
            
            CALayer* layer3rd = [CALayer layer];
            layer3rd.frame = (CGRect){161,0,((UIImage*)imgArr[2]).size};
            layer3rd.contents = (id)((UIImage*)imgArr[2]).CGImage;
            
            CALayer* layer4th = [CALayer layer];
            layer4th.frame = (CGRect){241,0,((UIImage*)imgArr[3]).size};
            layer4th.contents = (id)((UIImage*)imgArr[3]).CGImage;
            
            [[UIApplication sharedApplication].keyWindow.rootViewController.view.layer addSublayer:layer1st];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view.layer addSublayer:layer2nd];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view.layer addSublayer:layer3rd];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view.layer addSublayer:layer4th];
    
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                
//                UIImage* rotatedImage1st = [self getRotatedImage:imgArr[0]];
//                UIImage* rotatedImage2nd = [self getRotatedImage:imgArr[1]];
//                UIImage* rotatedImage3rd = [self getRotatedImage:imgArr[2]];
//                UIImage* rotatedImage4th = [self getRotatedImage:imgArr[3]];
                

                
                layer1st.transform = CATransform3DMakeScale(0, 1, 1); //CATransform3DMakeRotation(60.0*M_PI/180.0, 0, 1, 0);
                layer2nd.transform = CATransform3DMakeScale(0, 1, 1);//CATransform3DMakeRotation(30*M_PI/180.0, 0, 1, 0);
                layer3rd.transform = CATransform3DMakeScale(0, 1, 1);//CATransform3DMakeRotation(-30*M_PI/180.0, 0, 1, 0);
                layer4th.transform = CATransform3DMakeScale(0, 1, 1);//CATransform3DMakeRotation(-60.0*M_PI/180.0, 0, 1, 0);
                
                
            }completion:^(BOOL finished){
                fromVC.view.alpha = 1.0;
                toVC.view.alpha = 1.0;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                
                [layer1st removeFromSuperlayer];
                [layer2nd removeFromSuperlayer];
                [layer3rd removeFromSuperlayer];
                [layer4th removeFromSuperlayer];
                
            }];
#endif
//        }
//            break;
//        case ANIMATOR_TYPE_PUSHPOP:
//        default:
//        {
//            toVC.view.alpha = .0f;
//            
//            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//                fromVC.view.alpha = 0.0;
//                toVC.view.alpha = 1.0;
//            }completion:^(BOOL finished){
//                fromVC.view.alpha = 1.0;
//                toVC.view.alpha = 1.0;
//                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//            }];
//        }
//            break;
//    }
    
    
}


@end
