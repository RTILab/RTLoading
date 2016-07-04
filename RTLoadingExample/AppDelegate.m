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
        
    [UIView rt_configWithImage:nil                                                   
                indicatorColor:[UIColor whiteColor]
                     areaColor:[UIColor colorWithRed:0.0 green:0.7804 blue:0.5843 alpha:1.0]
               areaBorderColor:nil
                backgrounColor:[UIColor colorWithRed:0.1608 green:0.1333 blue:0.2549 alpha:1.0]];
    
    return YES;
}

@end
