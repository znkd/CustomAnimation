//
//  ToolLib.h
//  CustomAnimation
//
//  Created by zhangnan on 14/12/11.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#define SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width 
#define SCRREN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ToolLib : NSObject
+ (NSArray*)clip4Img:(UIImage*)rotateImg;
+ (UIImage*)getRotatedImage:(UIImage*)origionImage;
@end
