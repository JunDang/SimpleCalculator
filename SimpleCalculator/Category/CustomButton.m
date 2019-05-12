//
//  CustomButton.m
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/27/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import "CustomButton.h"


@implementation CustomButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor orangeColor];
    } else {
        self.backgroundColor =[UIColor colorWithRed:204/255.0 green:153.0/255.0 blue:0/255.0 alpha:1];;
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected: selected];
    
    if (selected) {
        self.backgroundColor = [UIColor orangeColor];
    } else {
        self.backgroundColor =[UIColor colorWithRed:204/255.0 green:153.0/255.0 blue:0/255.0 alpha:1];;
    }
}

@end
