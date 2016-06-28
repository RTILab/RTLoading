//
//  AppDelegate.m
//  RTLoadingExample
//
//  Created by RTILab on 6/27/16.
//  Copyright © 2016 RTILab. All rights reserved.
//

#import "AppDelegate.h"
#import "UIView+RTLoading.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        
    [UIView rt_configWithImage:nil // <- set indicator image
                indicatorColor:[UIColor redColor]
                     areaColor:[UIColor whiteColor]
               areaBorderColor:[UIColor redColor]
                backgrounColor:[UIColor lightGrayColor]];
    
    return YES;
}

@end
