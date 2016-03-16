//
//  ViewController.m
//  SFNetworkingExample
//
//  Created by 张洋威 on 16/3/16.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "ViewController.h"
#import "SFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [SFNetworking setKey:@"key"];
    
    [SFNetworking getWithBaseURL:@"host" path:@"path" parameters:@{@"paramKey": @"paramValue"} completion:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
