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
    for (int i = 2; i < number; i++) {
        if (number % i == 0) {
            prime = NO;
            break;
        }
    }
    return prime;
}

//Create an array of prime factors

- (NSArray *)getAllPrimeFactors:(NSUInteger)number {
    NSMutableArray *primeFactors = nil;
    int count = 2;
    
    while (count <= (int)number) {
        if ((number % count == 0) && [self isPrime:count]) {
            if (!primeFactors) {
                primeFactors = [[NSMutableArray alloc] init];
            }
            [primeFactors addObject:[NSString stringWithFormat:@"%d", count]];
        }
        count += 1;
    }
    return primeFactors;
    
}

// Determine the larget common prime factor between two numbers taken from two arrays **NEED HELP HERE**

- (NSInteger)getLargestPrimeFactorBetweenNumber:(NSUInteger)firstNumber andAnotherNumber:(NSUInteger)secondNumber {

    NSArray *firstNumberArray = [self getAllPrimeFactors:firstNumber]];
    NSArray *secondNumberArray = [self getAllPrimeFactors:secondNumber]];
   
    for{
        
    }
  
}

@end
