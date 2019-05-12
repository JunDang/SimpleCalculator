//
//  ViewController.m
//  SimpleCalculator
//
//  Created by Yinhuan Yuan on 4/25/19.
//  Copyright © 2019 Jun Dang. All rights reserved.
//

#import "ViewController.h"
#import "Model/Calculator_Brain.h"
#import "CustomButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (nonatomic) Calculator_Brain *cal;
@end

@implementation ViewController

-(Calculator_Brain*) cal { //object must be lazily instantiated in the getter;
    if(_cal == NULL) {
        _cal = [[Calculator_Brain alloc]init];
    }
    return _cal;
}

- (IBAction)numberBtnPressed:(UIButton *)sender {
    // if it is first display or if the first number for the calculation already exists, and the result label need be reset, then reset the result label be an empty string;
    if ((self.resultLblFirstDisplay) || (self.firstNumExists))
    {
        if (self.emptyResultLbl)
        {
            self.resultLbl.text = @"";
            self.resultLblFirstDisplay = false;
            self.emptyResultLbl = false;
        }
    }
    // if the first number for the calculation exists and an operator also exists, which means this button is inputting a second number ,then set the second number exists; This is for a continuous calculation, for example: 1 + 2 - 1 ;
    if (self.firstNumExists && self.hasCurrentOperator)
    {
        self.secondNumExists = true;
    }
    // if plus minus sign "+/" is pressed, then we need get the number of the opposite sign.
   // if it is the first number saved from last calculation, then it needs to be popped off the array stack. Then push back the number with the opposite sign.
    if (sender.tag == 12) {
        if (self.firstNumExists) {
            [self.cal popItem];
            double negativeNum = -self.firstNum;
            self.resultLbl.text = [NSString stringWithFormat: @"%g", negativeNum];
            [self.cal pushItem: negativeNum];
        } else {
            if ([self.resultLbl.text doubleValue] == 0) {
               self.resultLbl.text = @"-";
            } else {
               double negativeNum = -[self.resultLbl.text doubleValue];
               self.resultLbl.text = [NSString stringWithFormat: @"%g", negativeNum];
            }
        }
        self.hasCurrentOperator = false;
        return;
    }
    // if "%" button is pressed, then we need divide the value by 100.0; if it is the first number saved from last calculation, then it needs to be popped off the array stack. Then push back the number divided by 100.0 to the array stack for current calculation;
    if (sender.tag == 13)
    {
        double percentagedNum;
        if (self.firstNumExists) {
            [self.cal popItem];
            percentagedNum = self.firstNum / 100.0;
        } else {
            percentagedNum = [self.resultLbl.text doubleValue] / 100.0;
        }
        self.firstNum = percentagedNum;
        [self.cal pushItem:self.firstNum];
        self.firstNumExists = true;
        self.resultLbl.text = [NSString stringWithFormat: @"%g", percentagedNum];
        self.hasCurrentOperator = false;
        return;
    }
    // if a "." button is pressed, we need prevent the user to input another button by setting hasDot boolean value;
    if (sender.tag == 19) {
        if (!self.hasDot) {
             self.resultLbl.text = [NSString stringWithFormat:@"%@%@", self.resultLbl.text, sender.titleLabel.text];
            self.hasDot = true;
        }
    } else {
         self.resultLbl.text = [NSString stringWithFormat:@"%@%@", self.resultLbl.text, sender.titleLabel.text];
    }
}

// If an operator button is pressed, then we do the following:
- (IBAction)operationBtnPressed:(CustomButton *)sender
{
    // this boolean value should be set every time or else the result label will not display correctly;
    self.emptyResultLbl = true;
    
    //if it is pressed the first time, then we push the first number onto the array stack, and set the boolean value of hasCurrentOperator to true;
    if ((!self.firstNumExists) && (!self.hasCurrentOperator))
    {
        self.firstNum = [self.resultLbl.text doubleValue];
       
        [self.cal pushItem:self.firstNum];
         self.firstNumExists = true;
         self.hasDot = false;
    }

    // tell which operator button is pressed;
    if (sender.tag == 14) {
        self.currentOperation = [NSMutableString stringWithString: @"+"];
    }
    if (sender.tag == 15) {
        self.currentOperation = [NSMutableString stringWithString: @"-"];
    }
    if (sender.tag == 16) {
        self.currentOperation = [NSMutableString stringWithString: @"*"];
    }
    if (sender.tag == 17) {
        self.currentOperation =[NSMutableString stringWithString: @"/"];
    }
    self.hasCurrentOperator = true;
    
    // the previousOperation and currentOperation are designed if user use a continous calculation with operators only, for example: 1 + 2 - 3 * 2; the program calculate 1 + 2 firstly which get 3 then pushed to the array stack as the first number for calculation, then calculate 3 - 3 which is 0 , then calculate 0 * 2, and so forth;
    
    if (!self.hasPreviousOperator)
    {
        self.previousOperation = [NSMutableString stringWithString: self.currentOperation];
        self.hasPreviousOperator = true;
    }
    
    if (self.firstNumExists &&self.hasPreviousOperator && self.hasCurrentOperator && self.secondNumExists)
    {
        [self performCalculation:self.previousOperation];
        self.previousOperation = [NSMutableString stringWithString: self.currentOperation];
        self.hasPreviousOperator = true;
        self.hasCurrentOperator = true;
    }
}


- (IBAction)equalBtnPressed:(UIButton *)sender
{
    // if the equal button pressed,  then the second number is pushed to the array stack; then do the calculation; If the result equals the minimum value of Double, then show "error";
       [self performCalculation: self.currentOperation];
       self.hasPreviousOperator = false;
       self.hasCurrentOperator = false;
}

// if "AC" clear button pressed, then reset the calculator;
- (IBAction)clearBtnPressed:(UIButton *)sender
{
        sender.titleLabel.text = @"C";
        self.resultLbl.text = @"0";
        self.hasDot = false;
        self.resultLblFirstDisplay = true;
        self.hasPreviousOperator = false;
        self.hasCurrentOperator = false;
        self.firstNumExists = false;
        self.emptyResultLbl = true;
        [self.cal popItem];
}

-(void)performCalculation: (NSString *)operation
{
    self.secondNum = [self.resultLbl.text doubleValue];
    [self.cal pushItem:self.secondNum];
    double resultNum = [self.cal calculate: operation];
    if (resultNum == -DBL_MAX) {
        self.resultLbl.text = @"error";
        return;
    }
    self.resultLbl.text = [NSString stringWithFormat: @"%g", resultNum];
    
    // the result is used as the first number, which is pushed back to the stack array for next calculation;
    self.firstNum = [self.resultLbl.text doubleValue];
    [self.cal pushItem:self.firstNum];
    self.firstNumExists = true;
    self.hasDot = false;
    self.secondNumExists = false;
    self.resultLblFirstDisplay = true;
    self.emptyResultLbl = true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.resultLblFirstDisplay = true;
    self.hasDot = false;
    self.hasPreviousOperator = false;
    self.hasCurrentOperator = false;
    self.equalSignPressed = false;
    self.firstNum = 0.0;
    self.secondNum = 0.0;
    self.firstNumExists = false;
    self.secondNumExists = false;
    self.emptyResultLbl = true;
    /*Calculator_Brain *cal = [[Calculator_Brain alloc]init]; //object should always lazy instantiate;
    self.cal = cal;*/
}

@end
