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

@interface UIView (RTLoadingProperties)

@property (strong, nonatomic, readonly) UIView *_Nullable rt_loadingView;
@property (strong, nonatomic, readonly) RTLoadingIndicatorView *_Nullable rt_loading;

@end

@implementation UIView (RTLoadingProperties)

@dynamic rt_loadingView, rt_loading;

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

- (void)setRt_loading:(RTLoadingIndicatorView *)rt_loading
{
    [self willChangeValueForKey:@"RTLoadingIndicatorView"];
    objc_setAssociatedObject(self, &RTLoading,
                             rt_loading,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"RTLoadingIndicatorView"];
}

- (RTLoadingIndicatorView *)rt_loading
{
    return objc_getAssociatedObject(self, &RTLoading);
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



- (void)rt_showLoading
{
    [self rt_showLoading:nil
          indicatorColor:nil
               areaColor:nil
         areaBorderColor:nil
          backgrounColor:nil];
}

- (void)rt_showLoading:(UIImage *)image
        indicatorColor:(UIColor *)indicatorColor
             areaColor:(UIColor *)areaColor
       areaBorderColor:(UIColor *)areaBorderColor
        backgrounColor:(UIColor *)backgrounColor
{
    if (self.rt_loadingView) {
        if ([self.rt_loadingView.superview isEqual:self]) return;
 
        [self.rt_loadingView removeFromSuperview];
        self.rt_loadingView = nil;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeListener:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    self.rt_loading = [[[NSBundle mainBundle] loadNibNamed:@"RTLoadingIndicatorView"
                                                     owner:self
                                                   options:nil] objectAtIndex:0];
    
    id property = (image) ? image : [RTPropertiesContainer shared].indicatorImage;
    [self.rt_loading.IndicatorImage setImage:property];
    
    property = (areaColor) ? areaColor : [RTPropertiesContainer shared].areaViewColor;
    self.rt_loading.areaView.backgroundColor = property;
    
    property = (areaBorderColor) ? areaBorderColor : [RTPropertiesContainer shared].areaViewBorderColor;
    [self.rt_loading borderColor:property];
    
    property = (indicatorColor) ? indicatorColor : [RTPropertiesContainer shared].indicatorColor;
    
    if (property && ![property isEqual:[UIColor clearColor]]) {
        self.rt_loading.IndicatorImage.image = [self.rt_loading.IndicatorImage.image
                                                                       imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.rt_loading.IndicatorImage.tintColor = property;
    }
    
    self.rt_loadingView = [[UIView alloc] initWithFrame:self.frame];
    [self.rt_loadingView.layer setZPosition:100];
    
    property = (backgrounColor) ? backgrounColor : [RTPropertiesContainer shared].backgroundColor;
    self.rt_loadingView.backgroundColor = property;
    
    [self.rt_loadingView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rt_loading setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    __weak __typeof(self) weakSelf = self;
    
    [weakSelf.rt_loadingView addSubview:weakSelf.rt_loading];
    [weakSelf addSubview:weakSelf.rt_loadingView];
    
    [weakSelf applyConstrants:weakSelf target:weakSelf.rt_loadingView];
    
    id top = weakSelf.rt_loadingView;
    
    [top addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                options: NSLayoutFormatAlignAllCenterX
                                                                metrics:nil
                                                                  views:@{@"view" : weakSelf.rt_loading}]];
    
    [top addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                options:NSLayoutFormatAlignAllCenterY
                                                                metrics:nil
                                                                  views:@{@"view" : weakSelf.rt_loading}]];
    
    [weakSelf.rt_loading.IndicatorImage rt_startAnimating];
    
    weakSelf.rt_loadingView.alpha = 1;
    weakSelf.rt_loading.alpha = 0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         weakSelf.rt_loading.alpha = 1;
                     }];
}


- (void)rt_hideLoading
{
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
    [self removeListener:nil];
    if (self.rt_loadingView) {
        [self.rt_loadingView removeFromSuperview];
        self.rt_loadingView = nil;
        [self.rt_loading removeFromSuperview];
    }
}


- (void)appDidBecomeActive:(NSNotification*)note
{
    if (self.rt_loadingView) {
        [self.rt_loading.IndicatorImage rt_startAnimating];
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

- (void)applyConstrants:(UIView *)parent target:(UIView *)target
{
    if (!target) return;
    // Width constraint
    [parent addConstraint:[NSLayoutConstraint constraintWithItem:target
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:parent
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    
    // Height constraint
    [parent addConstraint:[NSLayoutConstraint constraintWithItem:target
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:parent
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    
    // Center horizontally
    [parent addConstraint:[NSLayoutConstraint constraintWithItem:target
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:parent
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // Center vertically
    [parent addConstraint:[NSLayoutConstraint constraintWithItem:target
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:parent
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
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
