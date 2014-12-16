//
//  ViewController.m
//  CustomAnimation
//
//  Created by zhangnan on 14/12/9.
//  Copyright (c) 2014年 zhangnan. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
#import "CustomAnimator.h"

@interface ViewController ()//<UINavigationControllerDelegate>
{
    
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"test";
    
    UIButton* pushViewBtn = [[UIButton alloc]initWithFrame:(CGRect){100.0,100.0,100.0,50.0}];
    [pushViewBtn setTitle:@"push" forState:UIControlStateNormal];
    
    [pushViewBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pushViewBtn];
    self.view.backgroundColor = [UIColor blueColor];
    
    _subVC = [[SubViewController alloc]initWithNibName:nil bundle:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push:(id)sender
{
    [self.navigationController pushViewController:_subVC animated:YES];
    
}

@end
