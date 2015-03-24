//
//  ViewController.m
//  Calculator
//
//  Created by Paul Desamero on 2/28/15.
//  Copyright (c) 2015 Paul.Desamero. All rights reserved.
//

#import "ViewController.h"
#import "CalcBrain.h"

/*  Private interface needed to add private properties.
    This is called a Class extension. The concept of "public 
    versus private" in Objective-C is done via "header file versus
    implementation file." 
    Declare public stuff in your header file's @interface-@end block.
    Declare private stuff in your implementation file's @interface-@end
    block.
 
 */
@interface ViewController()

/*  Nonatomic means that the setter and getter for this property will not
    be thread-safe. You will always use this keyword unless you really know 
    what you are doing.
 */
@property (nonatomic) BOOL userIsInMiddleOfEnteringANumber;
@property (nonatomic, strong) CalcBrain *brain;
@end



@implementation ViewController

@synthesize display;
@synthesize userIsInMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalcBrain *) brain
{
    if (!_brain) _brain = [[CalcBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    NSLog(@"User touched: %@", digit);
    
    /*  Express calling the getter of our display @property using
        dot notation instead of [self display] even though they
        both do the same thing.
     //UILabel *myDisplay = self.display;
    
    
        Get the text out of our display UILabel and store it in a
        local variable (a pointer to an NSString object) called
        currentDisplayText. text is a @property so use dot notation
    //NSString *currentDisplayText = self.display.text;
    
    
        stringByAppendString: returns a new NSString which is a copy of
        the receiving NSString (currentDisplay) with the arguement (digit)
        appended onto the end
    // NSString *newDisplayText =[currentDisplayText stringByAppendingString:digit];
    
        Now use UILabel's text @property's setter (setText:) to set the
        display UILabel's text to the new string with the digit appened
        to the end. Probably never use this normal method syntax to set
        a @property like this. Only used for illustrative purposes. 
        Should use [self.display setText:newDisplayText]; */
    
    
    if (self.userIsInMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        // if the user is not in the middle of typing just start off a new
        // number with the digit that was touched
        self.display.text = digit;
        self.userIsInMiddleOfEnteringANumber = YES;
    
    }

}

//Argument is None. Don't need the sender argument because there's only one Enter key.
//We can control whether an action message includes the sender as an argument with this pull-down.
- (IBAction)enterPressed {
    //all we need to do is push the double value of the display into the model (self.brain)
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInMiddleOfEnteringANumber) {
        [self enterPressed];    //implicit enter
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result]; //%g = floating point num
}


@end

