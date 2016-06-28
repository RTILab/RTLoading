//
//  RTLoadingIndicatorView.h
//  mosobleirc
//
//  Created by RTI Lab on 02.03.16.
//  Copyright © 2016 RTILab LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLoadingIndicatorView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *IndicatorImage;
@property (weak, nonatomic) IBOutlet UIView *areaView;

- (void)borderColor:(UIColor *)color;

@end
