#RTLoading
RTLoading is a extension which allow easy add loading indicator into any view.

<img src="https://github.com/RTILab/RTLoading/blob/master/Images/image.gif" width="300">

# Usage
```objective-c

#import <UIView+RTLoading.h>

```
##### Methods

```objective-c
/**
* Set configuration of loading view
* if was set nil then will set default value
*
*  @param image           Image of indicator. Max size is 40x40.
*  @param indicatorColor  Color of indicator image. If color is clear then will
*                         not be set tint of color of image. Default: nil.
*  @param areaColor       Color of area under indicator. Default: whiteColor.
*  @param areaBorderColor Color of area border. Default: clearColor.
*  @param backgrounColor  Color of view which will block content.
*                         Default: clearColor.
*/
+ (void)rt_configWithImage:(UIImage *_Nullable)image          
            indicatorColor:(UIColor *_Nullable)indicatorColor

                 areaColor:(UIColor *_Nullable)areaColor      
           areaBorderColor:(UIColor *_Nullable)areaBorderColor
            backgrounColor:(UIColor *_Nullable)backgrounColor;


/**
 *  Show loading view
 */
- (void)rt_showLoading;

/**
 * show loading view with custom configuration
 * if was set nil then will set default value
 *
 *  @param image           Image of indicator. Max size is 40x40.
 *  @param indicatorColor  Color of indicator image. If color is clear then will
 *                         not be set tint of color of image. Default: nil.
 *  @param areaColor       Color of area under indicator. Default: whiteColor.
 *  @param areaBorderColor Color of area border. Default: clearColor.
 *  @param backgrounColor  Color of view which will block content.
 *                         Default: clearColor.
 */
- (void)rt_showLoading:(UIImage *_Nullable)image
        indicatorColor:(UIColor *_Nullable)indicatorColor
             areaColor:(UIColor *_Nullable)areaColor
       areaBorderColor:(UIColor *_Nullable)areaBorderColor
        backgrounColor:(UIColor *_Nullable)backgrounColor;

/**
 *  Hide loading view
 */
- (void)rt_hideLoading;

/**
 *  Hide loading view without animation
 */
- (void)rt_fastHideLoading;


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
