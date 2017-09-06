//
//  ViewController.m
//  Calculator_OC
//
//  Created by 赵笑楠 on 27/06/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;

@end

@implementation ViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

//延迟初始化
- (CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc]init];
    
    return _brain;
}

//target,action  don't return any value
//id is pointer to any object
//参数id类型，会有很多不是button的备选项，选择错误会出现crash
//这里用UIButton，避免了这些失误
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;//[sender currentTitle];

    //debug,just like printf
    NSLog(@"digit press  = %@",digit);

    if (self.userIsInTheMiddleOfEnteringANumber){
        //自动将字符串添加到末尾再返回
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else{
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    
    double result = [self.brain performOperation:sender.currentTitle];
    
    self.display.text = [NSString stringWithFormat:@"%g",result];
    
}


@end
