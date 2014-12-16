//
//  CustomAnimator.h
//  CustomAnimation
//
//  Created by zhangnan on 14/12/9.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

enum ANIMATOR_TYPE {
    ANIMATOR_TYPE_PUSHPOP,
    ANIMATOR_TYPE_INTERACTION
};

typedef enum ANIMATOR_TYPE ANIMATOR_TYPE;

@interface CustomAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)ANIMATOR_TYPE animatorType;
@property(nonatomic,strong)UIImage* rotateImg;
@end
