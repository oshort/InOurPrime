//
//  ViewController.m
//  InOurPrime
//
//  Created by Oliver Short on 4/27/16.
//  Copyright © 2016 Oliver Short. All rights reserved.
//

#import "ViewController.h"
#import "PrimeBrain.h"

//OLIVER NOTE:Figure out a way to get our delegate to work so the app doesn't crash
@interface ViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

//Define our UI Properties
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UIButton *resultsButton;
@property (weak) IBOutlet UITextField *numbersTextField;
@property (weak) IBOutlet UILabel *resultsLabel;
@property (weak) IBOutlet UIPickerView *optionsPicker;

//Make some actions to connect with our picker
-(void)checkIfPrime:(NSString*)inputString;
-(void)retrievePrimeFactors:(NSString*)inputString;
-(void)retrieveLargestPrimeFactor:(NSString*)inputString;



//Array of strings to be defined in the UIPickerView
@property (strong) NSArray *optionsArray;


//Define the brain proerpty here so it can be reset later on
@property (strong)PrimeBrain *brain;

-(NSString *)formatStringFromArray: (NSArray*)optionsArray;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Delegates and data source 
    self.optionsPicker.delegate = self;
    self.optionsPicker.dataSource = self;
    
    //Initialize our brain
    self.brain = [[PrimeBrain alloc]init];
    
    //Set the choice options for our UIPickerView
    self.optionsArray = @[@"", @"Prime?", @"Prime factors?",@"Find the largest common prime factor"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)resultsButton:(UIButton *)sender{
    switch ([self.optionsPicker selectedRowInComponent:0]) {
    case 1:
        [self checkIfPrime:self.numbersTextField.text];
        break;
        
    case 2:
            [self retrievePrimeFactors:self.numbersTextField.text];
        break;
        
    case 3:
        if ([self.numbersTextField.text componentsSeparatedByString:@" "].count >= 2) {
            [self retrieveLargestPrimeFactor:self.numbersTextField.text];
        }
        break;
        
    default:
        break;
    }
    [self.numbersTextField resignFirstResponder];
}


-(void)checkIfPrime:(NSString *)inputString{
        if ([self.brain isPrime:[inputString integerValue]]) {
            self.resultsLabel.text = [NSString stringWithFormat:@"%@ is prime!", inputString];
        } else {
            self.resultsLabel.text = [NSString stringWithFormat:@"%@ is not prime!", inputString];
        }
    }


-(void)retrievePrimeFactors:(NSString *)inputString{
    NSArray *primefactors = [[NSArray alloc]init];
    primefactors = [self.brain getAllPrimeFactors: [inputString integerValue]];
    if (primefactors) {
        self.resultsLabel.text = [self formatStringFromArray: primefactors];
    }else{
            self.resultsLabel.text = [NSString stringWithFormat: @"There are no prime factors for %@.", inputString];
        }
    }


- (void)retrieveLargestPrimeFactor:(NSString *)numbersString {
    NSArray *numbers = [[NSArray alloc] initWithArray:[numbersString componentsSeparatedByString:@" "]];
    NSUInteger firstNumber = [numbers[0] integerValue];
    NSUInteger secondNumber = [numbers[1] integerValue];
    NSInteger largestCommonPrimeFactor = [self.brain getLargestPrimeFactorBetweenNumber:firstNumber andAnotherNumber:secondNumber];
    
    if (largestCommonPrimeFactor > 0) {
        self.resultsLabel.text = [NSString stringWithFormat:@"The largest common prime factor between %lu and %lu is %ld.", (unsigned long)firstNumber, (unsigned long)secondNumber, (long)largestCommonPrimeFactor];
    } else {
        self.resultsLabel.text = [NSString stringWithFormat:@"There are no common prime factors between %lu and %lu.", (unsigned long)firstNumber, (unsigned long)secondNumber];
    }
}

// Format a given array to output as a sentence with formatting for the possible answers
- (NSString *)formatStringFromArray:(NSArray *)numbersArray {
    NSString *answerString = @"";
    
    if (numbersArray.count > 1) {
        answerString = [NSString stringWithFormat:@"The prime factors for %@ are ", self.numbersTextField.text];
    } else {
        answerString = [NSString stringWithFormat:@"The prime factor for %@ is ", self.numbersTextField.text];
    }
    
    for (NSString *primeFactor in numbersArray) {
        if (numbersArray.count == 1) {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@", primeFactor]];
        } else if ((numbersArray.count == 2) && (primeFactor == [numbersArray firstObject])) {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@ ", primeFactor]];
        } else if (primeFactor == [numbersArray lastObject]) {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"and %@", primeFactor]];
        } else {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@, ", primeFactor]];
        }
    }
    
    answerString = [answerString stringByAppendingString:@"."];
    
    return answerString;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.optionsArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (row) {
        case 1:
            self.instructionsLabel.text = @"Enter a number to see if it's prime!";
            break;
            
        case 2:
            self.instructionsLabel.text = @"Enter a number to see its prime factors";
            break;
            
        case 3:
            self.instructionsLabel.text = @"Enter two numbers separated by a space to see the largest common prime factor between them.";
            break;
            
        default:
            self.instructionsLabel.text = @"";
            self.resultsButton.enabled = NO;
            break;
    }
}

#pragma mark - UIPickerViewDataSource

// Returns columns
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//Returns Rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.optionsArray.count;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.numbersTextField.text = @"";
    self.resultsButton.enabled = YES;
    self.resultsLabel.text = @"";
}

@end
