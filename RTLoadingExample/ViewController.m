//
//  ViewController.m
//  RTLoadingExample
//
//  Created by RTILab on 6/27/16.
//  Copyright © 2016 RTILab. All rights reserved.
//

#import "ViewController.h"
#import "UIView+RTLoading.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self run];
}

- (void)run {
    
    __weak typeof(self) weakSelf = self;
    
    [self.view rt_showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.view rt_hideLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf run];
        });
    });
}

@end
