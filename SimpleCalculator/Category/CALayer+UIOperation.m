//
//  CALayer+UIOperation.m
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/26/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import "CALayer+UIOperation.h"

@implementation CALayer (UIOperation)
@dynamic borderNewColor, borderNewWidth, cornerNewRadius;

-(void)setBorderNewColor:(UIColor *)color {
    [self setBorderColor: color.CGColor];
}

-(void)setBorderNewWidth:(CGFloat)borderWidth {
    [self setBorderWidth:borderWidth];
};

-(void)setCornerNewRadius:(CGFloat)cornerNewRadius {
    [self setCornerRadius:cornerNewRadius];
}

@end
