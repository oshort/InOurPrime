//
//  PrimeBrain.h
//  InOurPrime
//
//  Created by Oliver Short on 4/27/16.
//  Copyright © 2016 Oliver Short. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeBrain : NSObject

- (BOOL)isPrime:(NSUInteger)number;
- (NSArray *)getAllPrimeFactors:(NSUInteger)number;
- (NSInteger)getLargestPrimeFactorBetweenNumber:(NSUInteger)firstNumber andAnotherNumber:(NSUInteger)secondNumber;


@end
