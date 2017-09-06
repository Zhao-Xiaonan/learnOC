//
//  CalculatorBrain.m
//  Calculator_OC
//
//  Created by 赵笑楠 on 28/06/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *programStack;
@end


@implementation CalculatorBrain
//为指针创建实例变量,但指针指向的东西，需要分配
@synthesize programStack = _programStack;


//如果需要访问内存，只能在setter，getter中操作，而不能直接访问
- (NSMutableArray *)programStack
{
    //lazy instantiation延迟实例化，永远不会返回nil
    if (_programStack == nil) _programStack = [[NSMutableArray alloc]init];
    
    return _programStack;
    
}

- (void)pushOperand:(double)operand
{
//    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
//    [self.operandStack addObject:operandObject];
    
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    //操作符入栈
    [self.programStack addObject:operation];
    
    //执行运算
    return [CalculatorBrain runProgram:self.program];
    //self class返回这个实例的类
    //区别在于，这种写法可以调用CalculateBrain子类中对于runProgram的重写
    //return [[self class] runProgram:self.program];
}

//readonly 只有getter（获取programStack的不可变副本），没有setter
- (id)program
{
    //copy ①不需要直接交出内存，交出去的是个副本
    //②mutableArray复制后得到的是immutableArray
    return [self.programStack copy];
}


+ (NSString *) descriptionOfProgram:(id) program
{
    return @"implemente this in Assignment 2";
}

//从栈顶取数:取到operand，直接返回；取到operation，计算，返回结果
+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    //topOfStack可能是operation(NSString)，也可能是operand(NSNumber)
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    //取出的数是string还是number
    //若stack是个Array，但不止有String和Number，那么函数将返回0
    if([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue] ;
    }
    else if([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        
        if([operation isEqualToString:@"+"]){
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if([@"-" isEqualToString:operation]){
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        }
        else if([@"*" isEqualToString:operation]){
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if([@"/" isEqualToString:operation]){
            double divisor = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] / divisor;
        }
        else if([operation isEqualToString:@"√"]){
            result = sqrt([self popOperandOffStack:stack]);
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    //使用递归的方法实现计算器，需要可变数组
    NSMutableArray *stack;
    
    //防止crash，需要进行introspection
    //如果program不是NSArray，stack将会是nil，不会crash
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}


@end
