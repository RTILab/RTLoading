//
//  UIView+PlaceHolderView.h
//  mosobleirc
//
//  Created by RTI Lab on 02.03.16.
//  Copyright © 2016 RTILab LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLoadingIndicatorView.h"

@interface UIView (RTLoading)

#pragma mark - LoadingView
/*
 * set configuration of loading view
 * if was set nil then will set default value
 */
+ (void)rt_configWithImage:(UIImage *_Nullable)image          // <- Image of indicator. Max size is 40x40
            indicatorColor:(UIColor *_Nullable)indicatorColor // <- Color of indicator image.
                                                              //    If color is clear then will not be set tint of color of image.
                 areaColor:(UIColor *_Nullable)areaColor      // <- Color of area under indicator.
           areaBorderColor:(UIColor *_Nullable)areaBorderColor// <- Color of area border
            backgrounColor:(UIColor *_Nullable)backgrounColor;// <- Color of view which will block content

/*
 * show loading view
 */
- (void)rt_showLoading;

/*
 * show loading view with custom configuration
 * if was set nil then will set default value
 */
- (void)rt_showLoading:(UIImage *_Nullable)image
        indicatorColor:(UIColor *_Nullable)indicatorColor
             areaColor:(UIColor *_Nullable)areaColor
       areaBorderColor:(UIColor *_Nullable)areaBorderColor
        backgrounColor:(UIColor *_Nullable)backgrounColor;

/*
 * hide loading view
 */
- (void)rt_hideLoading;

/*
 * hide loading view without animation
 */
- (void)rt_fastHideLoading;

@end
