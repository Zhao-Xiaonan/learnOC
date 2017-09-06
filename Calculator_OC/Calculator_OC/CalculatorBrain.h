//
//  CalculatorBrain.h
//  Calculator_OC
//
//  Created by 赵笑楠 on 28/06/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;

- (double)performOperation:(NSString *)operation;

//ID 不透明类  ①不需要编写文档告诉使用API的人这是什么 ②可扩展性性强
//readonly提高效率；以后可以修改为readwrite
//这里没有指明是strong/weak，是因为只读的指针实际上并没有指向谁，只是返回
//返回结果可能将其变为局部变量（strong）或实例变量，这时才需要制定strong/weak
@property (readonly) id program;

//“+”代表类方法.执行类方法时，不能使用任何实例变量或实例方法，
//运行这个程序（去栈顶的数据），返回double（取到operand，直接返回；取到operation，计算，返回结果）
+ (double)runProgram:(id) program;

+ (NSString *)descriptionOfProgram:(id) program;

@end
