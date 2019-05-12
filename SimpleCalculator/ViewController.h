//
//  ViewController.h
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/25/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Calculator_Brain.h"

@interface ViewController : UIViewController
@property (nonatomic) Boolean hasPreviousOperator;
@property (nonatomic) Boolean hasCurrentOperator;
@property (nonatomic) Boolean hasDot;
@property (nonatomic) Boolean resultLblFirstDisplay;
@property (nonatomic) Boolean equalSignPressed;
@property (nonatomic) double firstNum;
@property (nonatomic) Boolean firstNumExists;
@property (nonatomic) double secondNum;
@property (nonatomic) Boolean secondNumExists;
@property (nonatomic) Boolean emptyResultLbl;
@property (nonatomic, strong) NSMutableString *currentOperation;
@property (nonatomic, strong) NSMutableString *previousOperation;


@end

