//
//  PrimeBrain.m
//  InOurPrime
//
//  Created by Oliver Short on 4/27/16.
//  Copyright © 2016 Oliver Short. All rights reserved.
//

#import "PrimeBrain.h"

@implementation PrimeBrain

//Determine if a number is prime using a for loop

-(BOOL) isPrime:(NSUInteger)number{
    BOOL prime = YES;
    for (int i = 2; i <= number - 1; i++) {
        if (number % i == 0) {
            prime = NO;
            break;
        }
    }
    return prime;
}

//Create an array of prime numbers

- (NSArray *)getAllPrimeFactors:(NSUInteger)number {
    NSMutableArray *primeFactors = nil;
    int counter = 2;
    
    while (counter <= (int)number) {
        if ((number % counter == 0) && [self isPrime:counter]) {
            if (!primeFactors) {
                primeFactors = [[NSMutableArray alloc] init];
            }
            [primeFactors addObject:[NSString stringWithFormat:@"%d", counter]];
        }
        counter += 1;
    }
    return primeFactors;
}

// Determine the larget common prime factor between two numbers taken from two arrays

- (NSInteger)getLargestPrimeFactorBetweenNumber:(NSUInteger)firstNumber andAnotherNumber:(NSUInteger)secondNumber {
    
    NSInteger largestCommonFactor = 0;
    
    NSArray *firstNumberArray = [[NSArray alloc] initWithArray:[self getAllPrimeFactors:firstNumber]];
    NSArray *secondNumberArray = [[NSArray alloc] initWithArray:[self getAllPrimeFactors:secondNumber]];
   
    
    if (firstNumberArray && secondNumberArray) {
        for (NSString *first in firstNumberArray) {
            for (NSString *second in secondNumberArray) {
                if (([first integerValue] == [second integerValue]) && ([first integerValue] > largestCommonFactor)) {
                    largestCommonFactor = [first integerValue];
                }
            }
        }
    }
    
    return largestCommonFactor;
}



@end
