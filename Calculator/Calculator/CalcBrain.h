//
//  CalcBrain.h
//  Calculator
//
//  Created by Paul Desamero on 3/18/15.
//  Copyright (c) 2015 Paul.Desamero. All rights reserved.
//

#import <Foundation/Foundation.h>

//Public API of our Model
//Public API are methods and properties other objects
//(besides our Model itself) are allowed to invoke
@interface CalcBrain : NSObject

//Method to provide a way to push operands onto our
//Calculator's stack of operands
- (void)pushOperand:(double)operand;

//Method that performs a given operation using the operands on the stack.
-(double)performOperation:(NSString *)operation;





@end
