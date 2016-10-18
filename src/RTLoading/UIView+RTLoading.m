//
//  UIView+PlaceHolderView.m
//  mosobleirc
//
//  Created by RTI Lab on 02.03.16.
//  Copyright © 2016 RTILab LLC. All rights reserved.
//

#import "UIView+RTLoading.h"
#import <objc/runtime.h>

#pragma mark - LoadingView Config

@interface RTPropertiesContainer : NSObject

@property (strong, nonatomic) NSString *defaultText;
@property (strong, nonatomic) UIColor *nobackgroundColor;

@property (strong, nonatomic) UIImage *indicatorImage;
@property (strong, nonatomic) UIColor *indicatorColor;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *areaViewColor;
@property (strong, nonatomic) UIColor *areaViewBorderColor;
@property (strong, nonatomic) UIView *custom;
@property (copy, nonatomic) RTLoadingAction action;

@end

@implementation RTPropertiesContainer

+ (instancetype)shared
{
    static RTPropertiesContainer *container = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        container = [[self alloc] init];
    });
    return container;
}

- (UIColor *)backgroundColor {
    if (_backgroundColor == nil) {
        _backgroundColor = [UIColor clearColor];
    }
    return _backgroundColor;
}

- (UIColor *)areaViewBorderColor {
    if (_areaViewBorderColor == nil) {
        _areaViewBorderColor = [UIColor clearColor];
    }
    return _areaViewBorderColor;
}

- (UIColor *)areaViewColor {
    if (_areaViewColor == nil) {
        _areaViewColor = [UIColor whiteColor];
    }
    return _areaViewColor;
}

- (UIImage *)indicatorImage {
    if (_indicatorImage == nil) {
        _indicatorImage = [UIImage imageNamed:@"rt_loader"];
    }
    return _indicatorImage;
}

@end


#pragma mark - LoadingView Properties

static char RTLoadingView;
static char RTLoading;
static char RTIndicator;

@interface UIView (RTLoadingProperties)

    @property (strong, nonatomic, readonly) UIView *_Nullable rt_loadingView;
    @property (strong, nonatomic, readonly) UIView *_Nullable rt_loading;
    @property (strong, nonatomic, readonly) UIView *_Nullable rt_indicator;

@end

@implementation UIView (RTLoadingProperties)

@dynamic rt_loadingView, rt_loading, rt_indicator;

- (void)setRt_loadingView:(UIView *)rt_loadingView
{
    [self willChangeValueForKey:@"RTLoadingView"];
    objc_setAssociatedObject(self, &RTLoadingView,
                             rt_loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"RTLoadingView"];
}

- (UIView *)rt_loadingView
{
    return objc_getAssociatedObject(self, &RTLoadingView);
}

- (void)setRt_loading:(UIView *)rt_loading
{
    [self willChangeValueForKey:@"RTLoadingIndicatorView"];
    objc_setAssociatedObject(self, &RTLoading,
                             rt_loading,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"RTLoadingIndicatorView"];
}

- (UIView *)rt_loading
{
    return objc_getAssociatedObject(self, &RTLoading);
}
    
- (void)setRt_indicator:(UIView *)rt_loading
{
    [self willChangeValueForKey:@"RTIndicator"];
    objc_setAssociatedObject(self, &RTIndicator,
                             rt_loading,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"RTIndicator"];
}
    
- (UIView *)rt_indicator
{
    return objc_getAssociatedObject(self, &RTIndicator);
}

@end


#pragma mark - LoadingView

@implementation UIView (RTLoading)

- (UIColor *)inverseColor:(UIColor *)color
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

+ (void)rt_configWithImage:(UIImage *_Nullable)image
            indicatorColor:(UIColor *_Nullable)indicatorColor
                 areaColor:(UIColor *_Nullable)areaColor
           areaBorderColor:(UIColor *_Nullable)areaBorderColor
            backgrounColor:(UIColor *_Nullable)backgrounColor
{
    if (image) [RTPropertiesContainer shared].indicatorImage = image;
    if (indicatorColor) [RTPropertiesContainer shared].indicatorColor = indicatorColor;
    if (areaColor) [RTPropertiesContainer shared].areaViewColor = areaColor;
    if (areaBorderColor) [RTPropertiesContainer shared].areaViewBorderColor = areaBorderColor;
    if (backgrounColor) [RTPropertiesContainer shared].backgroundColor = backgrounColor;
}

+ (void)rt_configWithView:(UIView *_Nonnull)view
                 areaColor:(UIColor *_Nullable)areaColor
           areaBorderColor:(UIColor *_Nullable)areaBorderColor
           backgrounColor:(UIColor *_Nullable)backgrounColor
                   action:(RTLoadingAction _Nullable)action
{
    if (areaColor) [RTPropertiesContainer shared].areaViewColor = areaColor;
    if (areaBorderColor) [RTPropertiesContainer shared].areaViewBorderColor = areaBorderColor;
    if (backgrounColor) [RTPropertiesContainer shared].backgroundColor = backgrounColor;
    [RTPropertiesContainer shared].custom = view;
    [RTPropertiesContainer shared].action = action;
}

- (void)rt_showLoading
{
    [self rt_showLoading:nil
          indicatorColor:nil
               areaColor:nil
         areaBorderColor:nil
          backgrounColor:nil
              customView:nil
                  action:nil];
}

- (void)rt_showLoading:(UIImage *)image
        indicatorColor:(UIColor *)indicatorColor
             areaColor:(UIColor *)areaColor
       areaBorderColor:(UIColor *)areaBorderColor
        backgrounColor:(UIColor *)backgrounColor {
    [self rt_showLoading:image
          indicatorColor:indicatorColor
               areaColor:areaColor
         areaBorderColor:areaBorderColor
          backgrounColor:backgrounColor
              customView:nil
                  action:nil];
}


- (void)rt_showLoading:(UIView *)custom
             areaColor:(UIColor *)areaColor
       areaBorderColor:(UIColor *)areaBorderColor
        backgrounColor:(UIColor *)backgrounColor
                action:(RTLoadingAction)action{
    [self rt_showLoading:nil
          indicatorColor:nil
               areaColor:areaColor
         areaBorderColor:areaBorderColor
          backgrounColor:backgrounColor
              customView:custom
                  action:action];
}

- (void)rt_showLoading:(UIImage *)image
        indicatorColor:(UIColor *)indicatorColor
             areaColor:(UIColor *)areaColor
       areaBorderColor:(UIColor *)areaBorderColor
        backgrounColor:(UIColor *)backgrounColor
            customView:(UIView *)custom
                action:(RTLoadingAction)action
{
    if (self.rt_loadingView) {
        if ([self.rt_loadingView.superview isEqual:self]) return;
 
        [self.rt_loadingView removeFromSuperview];
        self.rt_loadingView = nil;
        self.rt_indicator = nil;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeListener:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    self.rt_loading = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.rt_loading.layer.cornerRadius = 10;
    self.rt_loading.layer.borderWidth = 2;
    
    id property = (custom) ? custom : [RTPropertiesContainer shared].custom;
    if (property == nil) {
        self.rt_indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        UIImageView *idicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        [self.rt_loading addSubview:self.rt_indicator];
        [self.rt_indicator addSubview:idicatorView];
        
        property = (image) ? image : [RTPropertiesContainer shared].indicatorImage;
        [idicatorView setImage:property];
        
        property = (indicatorColor) ? indicatorColor : [RTPropertiesContainer shared].indicatorColor;
        
        if (property && ![property isEqual:[UIColor clearColor]]) {
            idicatorView.image = [idicatorView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            idicatorView.tintColor = property;
        }
        
    } else {
        UIView *c = property;
        [self.rt_loading addSubview:c];
    }
    
    property = (areaColor) ? areaColor : [RTPropertiesContainer shared].areaViewColor;
    self.rt_loading.backgroundColor = property;
    
    property = (areaBorderColor) ? areaBorderColor : [RTPropertiesContainer shared].areaViewBorderColor;
    self.rt_loading.layer.borderColor = ((UIColor *)property).CGColor;
    
    self.rt_loadingView = [[UIView alloc] initWithFrame:self.bounds];
    [self.rt_loadingView.layer setZPosition:100];
    
    property = (backgrounColor) ? backgrounColor : [RTPropertiesContainer shared].backgroundColor;
    self.rt_loadingView.backgroundColor = property;
    
    [self.rt_loadingView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rt_loading setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.rt_loadingView addSubview:self.rt_loading];
    [self addSubview:self.rt_loadingView];
    
    if (self.rt_indicator) {
        [self.rt_indicator rt_startAnimating];
    }
    
    self.rt_loadingView.alpha = 1;
    self.rt_loading.alpha = 0;
    
    UIWindow *w = UIApplication.sharedApplication.keyWindow;
    self.rt_loading.center = [w convertPoint:w.center toView:self.rt_loadingView];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.rt_loading.alpha = 1;
                     }];
    RTLoadingAction currentAction = (action) ? action : [RTPropertiesContainer shared].action;
    if (currentAction) {
        currentAction(RTLoadingStateBegin);
    }
}


- (void)rt_hideLoading
{
    RTLoadingAction currentAction = [RTPropertiesContainer shared].action;
    if (currentAction) {
        currentAction(RTLoadingStateEnd);
        [[RTPropertiesContainer shared].custom removeFromSuperview];
    }
    [self removeListener:nil];
    if (self.rt_loadingView) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.rt_loadingView.alpha = 0;
                             self.rt_loading.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [self.rt_loadingView removeFromSuperview];
                             self.rt_loadingView = nil;
                             [self.rt_loading removeFromSuperview];

                         }];
    }
}

- (void)rt_fastHideLoading
{
    RTLoadingAction currentAction = [RTPropertiesContainer shared].action;
    if (currentAction) {
        currentAction(RTLoadingStateEnd);
        [[RTPropertiesContainer shared].custom removeFromSuperview];
    }
    [self removeListener:nil];
    if (self.rt_loadingView) {
        [self.rt_loadingView removeFromSuperview];
        self.rt_loadingView = nil;
        [self.rt_loading removeFromSuperview];
    }
}


- (void)appDidBecomeActive:(NSNotification*)note
{
    if (self.rt_loadingView && self.rt_indicator) {
        [self.rt_indicator rt_startAnimating];
    
        RTLoadingAction currentAction = [RTPropertiesContainer shared].action;
        if (currentAction) {
            currentAction(RTLoadingStateRestore);
        }
    }
}

-(void)removeListener:(NSNotification*)note
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillTerminateNotification
                                                  object:nil];
    
}

#pragma mark - Animating

- (void)rt_startAnimating
{
    self.hidden=false;
    CABasicAnimation *fullRotation  = [[CABasicAnimation alloc] init];
    fullRotation.keyPath = @"transform.rotation";
    fullRotation.fromValue = [NSNumber numberWithDouble:0];
    fullRotation.toValue = [NSNumber numberWithDouble:((360*M_PI)/180.0)];
    fullRotation.duration = 0.5;
    fullRotation.repeatCount = HUGE;
    [self.layer addAnimation:fullRotation forKey:@"360"];
}

- (void)rt_stopAnimating
{
    [self.layer removeAllAnimations];
    self.hidden = true;
}

@end
