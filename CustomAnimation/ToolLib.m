//
//  ToolLib.m
//  CustomAnimation
//
//  Created by zhangnan on 14/12/11.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import "ToolLib.h"

@implementation ToolLib
+ (NSArray*)clip4Img:(UIImage*)rotateImg
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    CGImageRef imageRef = rotateImg.CGImage;
    
    CGImageRef image1stRef = CGImageCreateWithImageInRect(imageRef, (CGRect){0,0,rect.size.width/4,rect.size.height});
    UIImage* image1st = [UIImage imageWithCGImage:image1stRef];
    
    CGImageRef image2ndRef = CGImageCreateWithImageInRect(imageRef, (CGRect){rect.size.width/4,0,rect.size.width/4,rect.size.height});
    UIImage* image2nd = [UIImage imageWithCGImage:image2ndRef];
    
    CGImageRef image3rdRef = CGImageCreateWithImageInRect(imageRef, (CGRect){rect.size.width/2,0,rect.size.width/4,rect.size.height});
    UIImage* image3rd = [UIImage imageWithCGImage:image3rdRef];
    
    CGImageRef image4thRef = CGImageCreateWithImageInRect(imageRef, (CGRect){3*rect.size.width/4,0,rect.size.width/4,rect.size.height});
    UIImage* image4th = [UIImage imageWithCGImage:image4thRef];
    
    return @[image1st,image2nd,image3rd,image4th];
}

+ (UIImage*)getRotatedImage:(UIImage*)origionImage
{
    float rotate = M_PI/6;
    
    UIView* viewBox = [[UIView alloc]initWithFrame:(CGRect){0,0,origionImage.size}];
    
    //    CGAffineTransform t = CGAffineTransformMakeRotation(rotate);
    //    viewBox.transform = CGAffineTransformScale(t, 0.75, 0.92);
    
    CATransform3D transform3D = CATransform3DMakeRotation(rotate, 0, 1, 0);
    viewBox.layer.transform = transform3D;//CATransform3DScale(transform3D, 0.75, 0.92, 1);
    
    CGSize size = viewBox.frame.size;
    
    
    UIGraphicsBeginImageContext(size);
    CGContextRef curRef = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(curRef, size.width/2, size.height/2);
    CGContextRotateCTM(curRef, rotate);
    CGContextScaleCTM(curRef, 1.0, -1.0);
    
    CGContextDrawImage(curRef, (CGRect){-size.width/2,-size.height/2,size}, origionImage.CGImage);
    
    UIImage* imageGenerate = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageGenerate;
    
    
}
@end
