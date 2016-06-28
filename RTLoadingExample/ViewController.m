//
//  ViewController.m
//  RTLoadingExample
//
//  Created by RTILab on 6/27/16.
//  Copyright © 2016 RTILab. All rights reserved.
//

#import "ViewController.h"
#import "UIView+RTLoading.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *test1;
@property (weak, nonatomic) IBOutlet UIView *test2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self run];
}

- (void)run {
    
    __weak typeof(self) weakSelf = self;
    
    [self.view rt_showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view rt_hideLoading];
    });
    
    [weakSelf.test1 rt_showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.test1 rt_hideLoading];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf run];
        });
        
    });
    
    [self.test2 rt_showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.test2 rt_hideLoading];
    });
}

@end
