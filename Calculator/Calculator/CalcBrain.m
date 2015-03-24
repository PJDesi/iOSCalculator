//
//  CalcBrain.m
//  Calculator
//
//  Created by Paul Desamero on 3/18/15.
//  Copyright (c) 2015 Paul.Desamero. All rights reserved.
//

#import "CalcBrain.h"

@interface CalcBrain()
//Strong: keep this object (the array) around until I'm done using it.
//Nonatomic: not thread-safe
@property (nonatomic, strong) NSMutableArray *operandStack;
@end


@implementation CalcBrain

@synthesize operandStack = _operandStack;


- (NSMutableArray *) operandStack;
{
    //This is how you create an object.
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

-(void)pushOperand:(double)operand
{
    //NSMutableArray is an array of objects and operand is a
    //double, which is a primitive type, not an object.
    //So, use NSNumber which wraps primitive types into an object.
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    
    //Check to see if we actually got a non-nill operandObject
    //from the array before trying to call removeLastObject
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

-(double)performOperation:(NSString *)operation
{
    double result = 0;
    
    // perform opertion here, store answer in result
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    }
    
    //Finally, push the result back onto the stack so that the
    //next operation will use it
    [self pushOperand:result];
    
    return result;
}

@end
