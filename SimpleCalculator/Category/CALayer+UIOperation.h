//
//  CALayer+UIOperation.h
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/26/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface CALayer (UIOperation)

@property (nonatomic) IBInspectable UIColor *borderNewColor;
@property (nonatomic) IBInspectable CGFloat borderNewWidth;
@property (nonatomic) IBInspectable CGFloat cornerNewRadius;

@end

NS_ASSUME_NONNULL_END
