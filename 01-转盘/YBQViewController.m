//
//  YBQViewController.m
//  01-转盘
//
//  Created by 严必庆 on 15-6-6.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "YBQViewController.h"
#import "BQWheel.h"
@interface YBQViewController ()

@end

@implementation YBQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    BQWheel *wheel = [BQWheel wheel];
    wheel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [self.view addSubview:wheel];
    [wheel startRoatating];
}



@end
