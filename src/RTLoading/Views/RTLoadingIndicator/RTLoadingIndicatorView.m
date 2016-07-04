//
//  RTLoadingIndicatorView.m
//  mosobleirc
//
//  Created by RTI Lab on 02.03.16.
//  Copyright © 2016 RTILab LLC. All rights reserved.
//

#import "RTLoadingIndicatorView.h"

@implementation RTLoadingIndicatorView

- (void)awakeFromNib {
    self.areaView.layer.cornerRadius = 10;
    self.areaView.layer.borderWidth = 2;
    [super awakeFromNib];
}

- (void)borderColor:(UIColor *)color {
    self.areaView.layer.borderColor = color.CGColor;
    if ([color isEqual:[UIColor clearColor]]) {
        self.areaView.layer.borderWidth = 0;
    }
}

@end
