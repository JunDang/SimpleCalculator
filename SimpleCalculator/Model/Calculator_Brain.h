//
//  Calculator_Brain.h
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/26/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface Calculator_Brain : NSObject

-(void)pushItem: (double) number;
-(double)calculate : (NSString *) oparation;
-(double)popItem;
//make the getter method public so that the array can be printed out in the main function;
-(NSMutableArray *) items;


@end

NS_ASSUME_NONNULL_END
