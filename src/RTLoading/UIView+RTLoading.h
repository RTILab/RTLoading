//
//  UIView+PlaceHolderView.h
//  mosobleirc
//
//  Created by RTI Lab on 02.03.16.
//  Copyright © 2016 RTILab LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, RTLoadingState) {
    RTLoadingStateBegin,
    RTLoadingStateEnd,
    RTLoadingStateRestore
};
typedef void (^RTLoadingAction)(RTLoadingState state) ;

@interface UIView (RTLoading)

#pragma mark - LoadingView

/**
 * Set configuration of loading view
 * if was set nil then will set default value
 *
 *  @param image           Image of indicator. Size is 20x20.
 *  @param indicatorColor  Color of indicator image. If color is clear then will not be set tint of color of image. Default: nil.
 *  @param areaColor       Color of area under indicator. Default: whiteColor.
 *  @param areaBorderColor Color of area border. Default: clearColor.
 *  @param backgrounColor  Color of view which will block content. Default: clearColor.
 */
+ (void)rt_configWithImage:(UIImage *_Nullable)image
            indicatorColor:(UIColor *_Nullable)indicatorColor
                 areaColor:(UIColor *_Nullable)areaColor
           areaBorderColor:(UIColor *_Nullable)areaBorderColor
            backgrounColor:(UIColor *_Nullable)backgrounColor;

/**
 * Set configuration of loading view
 * if was set nil then will set default value
 *
 *  @param custom          Custom indicatorView.
 *  @param areaColor       Color of area under indicator. Default: whiteColor.
 *  @param areaBorderColor Color of area border. Default: clearColor.
 *  @param backgrounColor  Color of view which will block content. Default: clearColor.
 *  @param action          Callback of state.
*/

+ (void)rt_configWithView:(UIView *_Nonnull)custom
                areaColor:(UIColor *_Nullable)areaColor
          areaBorderColor:(UIColor *_Nullable)areaBorderColor
           backgrounColor:(UIColor *_Nullable)backgrounColor
                   action:(RTLoadingAction _Nullable)action;


/**
 *  Show loading view
 */
- (void)rt_showLoading;

/**
 * show loading view with custom configuration
 * if was set nil then will set default value
 *
 *  @param image           Image of indicator. Max size is 40x40.
 *  @param indicatorColor  Color of indicator image. If color is clear then will not be set tint of color of image. Default: nil.
 *  @param areaColor       Color of area under indicator. Default: whiteColor.
 *  @param areaBorderColor Color of area border. Default: clearColor.
 *  @param backgrounColor  Color of view which will block content. Default: clearColor.
 */
- (void)rt_showLoading:(UIImage *_Nullable)image
        indicatorColor:(UIColor *_Nullable)indicatorColor
             areaColor:(UIColor *_Nullable)areaColor
       areaBorderColor:(UIColor *_Nullable)areaBorderColor
        backgrounColor:(UIColor *_Nullable)backgrounColor;

- (void)rt_showLoading:(UIView *_Nonnull)custom
             areaColor:(UIColor *_Nullable)areaColor
       areaBorderColor:(UIColor *_Nullable)areaBorderColor
        backgrounColor:(UIColor *_Nullable)backgrounColor
                action:(RTLoadingAction _Nullable)action;

/**
 *  Hide loading view
 */
- (void)rt_hideLoading;

/**
 *  Hide loading view without animation
 */
- (void)rt_fastHideLoading;

@end
