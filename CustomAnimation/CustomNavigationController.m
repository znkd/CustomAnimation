//
//  CustomNavigationController.m
//  CustomAnimation
//
//  Created by zhangnan on 14/12/9.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import "CustomNavigationController.h"
#import "NavigationCustomAnimationDelegate.h"
#import "ViewController.h"
#import "ToolLib.h"

@interface CustomNavigationController ()
{
    NavigationCustomAnimationDelegate* _navDelegate;
    
    UIPanGestureRecognizer* panGesture;
    
    CGPoint locationGP;
    CGPoint preLocationGP;
    
    float allMoveDis;
    
    UIImage* screenImg;
    
    CALayer* layer1st;
    CALayer* layer2nd;
    CALayer* layer3rd;
    CALayer* layer4th;
    
    UIView* maskView;
    
}
@end

@implementation CustomNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        _navDelegate = [[NavigationCustomAnimationDelegate alloc]init];
        self.delegate = _navDelegate;
        
        panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandler:)];
        
        [self.view addGestureRecognizer:panGesture];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#if 0 //reserve
- (void)panHandler:(UIGestureRecognizer*)recg
{
    if (recg.state == UIGestureRecognizerStateBegan) {
        screenImg = [self snapShot];
        
        ((NavigationCustomAnimationDelegate*)self.delegate).interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
        
        locationGP = [recg locationInView:self.view];
        
        [((NavigationCustomAnimationDelegate*)self.delegate) setRotateImage:screenImg];
        
        ViewController* ctler = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
        
        [self pushViewController:(UIViewController*)ctler.subVC animated:YES];
        
        
    } else if (recg.state == UIGestureRecognizerStateChanged) {
        CGPoint curLocationGP = [recg locationInView:self.view];
        
        int deletaX = curLocationGP.x - locationGP.x;
        
        float theteArc = deletaX/SCRREN_WIDTH;//(M_PI*deletaX)/320.0 * -1.0;
        
        [((NavigationCustomAnimationDelegate*)self.delegate).interactionController updateInteractiveTransition:theteArc];
        
    } else if (recg.state == UIGestureRecognizerStateCancelled || recg.state == UIGestureRecognizerStateEnded) {
        ((NavigationCustomAnimationDelegate*)self.delegate).interactionController = nil;
    }
}
#else
- (void)panHandler:(UIGestureRecognizer*)recg
{
    if (recg.state == UIGestureRecognizerStateBegan) {
        
        maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        maskView.backgroundColor = [UIColor whiteColor];
        maskView.alpha = 0.8;
        
        
        screenImg = [self snapShot];

        locationGP = [recg locationInView:self.view];
        
        NSArray* imgArr = [ToolLib clip4Img:screenImg];
        
        int deletX = 0;
        
        layer1st = [CALayer layer];
        layer1st.frame = (CGRect){0,0,((UIImage*)imgArr[0]).size};
        layer1st.contents = (id)((UIImage*)imgArr[0]).CGImage;
        
        deletX += (layer1st.frame.origin.x + layer1st.frame.size.width);
        
        layer2nd = [CALayer layer];
        layer2nd.frame = (CGRect){deletX,0,((UIImage*)imgArr[1]).size};
        layer2nd.contents = (id)((UIImage*)imgArr[1]).CGImage;
        
        deletX += layer2nd.frame.size.width;
        
        layer3rd = [CALayer layer];
        layer3rd.frame = (CGRect){deletX,0,((UIImage*)imgArr[2]).size};
        layer3rd.contents = (id)((UIImage*)imgArr[2]).CGImage;
        
        deletX += layer3rd.frame.size.width;
        
        
        layer4th = [CALayer layer];
        layer4th.frame = (CGRect){deletX,0,((UIImage*)imgArr[3]).size};
        layer4th.contents = (id)((UIImage*)imgArr[3]).CGImage;
        
        
        [maskView.layer addSublayer:layer1st];
        [maskView.layer addSublayer:layer2nd];
        [maskView.layer addSublayer:layer3rd];
        [maskView.layer addSublayer:layer4th];
        
        [self.view addSubview:maskView];

        
    } else if (recg.state == UIGestureRecognizerStateChanged) {
        CGPoint curLocationGP = [recg locationInView:self.view];
        
        int deletaX = curLocationGP.x - locationGP.x;
        
        allMoveDis += deletaX;
        
        float theteArc = (8*M_PI*allMoveDis)/SCRREN_WIDTH;
        
        NSLog(@"allMove = %f;deletax = %d",allMoveDis,deletaX);
        
//        CATransform3D transformAdded = CATransform3DMakeTranslation(, 0, 0);
//        CATransform3DTranslate(, <#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
        
        if (fabs(allMoveDis) < SCRREN_WIDTH/4) {
            CATransform3D tfReal;
            
            CATransform3D rotationTemp = CATransform3DMakeRotation(theteArc, 0, 1, 0);
            CATransform3D temp = CATransform3DPerspect(rotationTemp, CGPointMake(0, 0), 400);
            
            if (fabs(allMoveDis) < SCRREN_WIDTH/8) {
                //left transform
                CATransform3D tf = CATransform3DMakeTranslation(1, 0, 0);
                tfReal = CATransform3DTranslate(tf, allMoveDis, 0, 0);
                layer1st.transform = tfReal;//CATransform3DConcat(temp,tfReal);
            } else {
//                if (fabs(allMoveDis) < SCRREN_WIDTH/8+1) {
//                    layer1st.frame = (CGRect){-SCRREN_WIDTH/8,0,layer1st.frame.size};
//                } else{
                    //right transform
                    CATransform3D tf = CATransform3DMakeTranslation(1, 0, 0);
                    tfReal = CATransform3DTranslate(tf, (SCRREN_WIDTH/4-fabs(allMoveDis)), 0, 0);
                    layer1st.transform = tfReal;//CATransform3DConcat(temp,tfReal);
//                }
                
                
            }
            
            
        }else if (fabs(allMoveDis) >= SCRREN_WIDTH/4) {
            CATransform3D tf = CATransform3DMakeTranslation(-1, 0, 0);
            CATransform3D tfReal = CATransform3DTranslate(tf, fabs(deletaX), 0, 0);
            layer1st.transform = tfReal;
        }
        
        //layer1st.transform = temp;
        //layer2nd.transform = temp;
        //layer3rd.transform = temp;
        //layer4th.transform = temp;
        
//        if (layer1st.frame.origin.x <= 0) {
//            
//        }
        
        locationGP = curLocationGP;
        
    } else if (recg.state == UIGestureRecognizerStateCancelled || recg.state == UIGestureRecognizerStateEnded) {
        
        [layer1st removeFromSuperlayer];
        [layer2nd removeFromSuperlayer];
        [layer3rd removeFromSuperlayer];
        [layer4th removeFromSuperlayer];
        [maskView removeFromSuperview];
        
        allMoveDis = 0;
    }
}
#endif

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}
CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}


- (UIImage*)snapShot
{
    UIGraphicsBeginImageContext([[UIScreen mainScreen] bounds].size);
    CGContextRef curCtx = UIGraphicsGetCurrentContext();
    
    //CGContextSaveGState(curCtx);
    
    //[[UIApplication sharedApplication].keyWindow.rootViewController.view.layer renderInContext:curCtx];
    [self.view.layer renderInContext:curCtx];
    
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    
    //CGContextRestoreGState(curCtx);
    
    UIGraphicsEndImageContext();
    
    return img;
}



@end
