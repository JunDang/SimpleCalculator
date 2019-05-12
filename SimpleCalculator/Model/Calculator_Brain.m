//
//  Calculator_Brain.m
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/26/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import "Calculator_Brain.h"

@interface Calculator_Brain()
@property (nonatomic, strong) NSMutableArray *items;
@end;

@implementation Calculator_Brain

@synthesize items = _items;

// late instantiation
-(NSMutableArray *) items {
    if (_items == nil) {
        _items = [[NSMutableArray alloc]init];
    }
    return _items;
}

-(void) setItems:(NSMutableArray *)items {
    _items = items;
}

-(void)pushItem: (double) number {
    NSNumber *num = [[NSNumber alloc]initWithDouble:number];   
    [self.items addObject:num];
}
// if the array is empty, then just return 0.0;
-(double)popItem {
    if ([self.items count] != 0) {
        NSNumber *num = [self.items lastObject];
        [self.items removeLastObject];
        double doubleNum = [num doubleValue];
        return doubleNum;
    }
    return 0.0;
}
//if operation is division and if the deominator is zero, then print a message and return the minimum value of double; If the operator was not defined, then return the double's minmum value as well;
-(double) calculate : (NSString *) operation {
    double item1 = [self popItem];
    double item2 = [self popItem];
    
    if ([operation isEqualToString:@"+"]) {
        return  item1 + item2;
    } else if ([operation isEqualToString:@"-"]) {
        return item2 - item1;
    } else if ([operation isEqualToString:@"*"]) {
        return item1 * item2;
    } else if ([operation isEqualToString:@"/"]) {
        if (item1 == 0) {
            NSLog(@"warning: please enter a non-zero denominator.");
            return -DBL_MAX;
        }
        return item2 / item1;
    } else {
        NSLog(@"warning: the operator has not been defined.");
        return -DBL_MAX;
    }
}



@end

