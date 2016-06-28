#RTLoading
RTLoading is a extension which allow easy add loading indicator into any view.

<img src="https://github.com/RTILab/RTLoading/blob/master/Images/image.gif">

# Usage
```objective-c
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
```


## Install

RTDataSourceAdapter is available through CocoaPods. To install it, simply add the following line to your Podfile:

```objective-c
pod install 'RTLoading'
```
In case you don’t want to use CocoaPods - just copy the folder src to your Xcode project.

### Maintainers
- [Morozov Ivan](https://github.com/Allui)
- [RTILab](https://github.com/RTILab)

## License

RTLoading is available under the MIT license. See the LICENSE file for more info.
