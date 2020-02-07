//
//  ViewController.m
//  VerificationCode
//
//  Created by Ten on 2020/2/5.
//  Copyright © 2020年 KNone. All rights reserved.
//

#import "ViewController.h"
#import "VerificationCodeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VerificationCodeView *view = [[VerificationCodeView alloc]initWithFrame:CGRectMake(100, 50, 300, 300)];
    [self.view addSubview:view];
}


@end
