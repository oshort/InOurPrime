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

@property (weak) IBOutlet UITextField *numbersTextField;
@property (weak) IBOutlet UILabel *resultsLabel;
@property (weak) IBOutlet UIPickerView *optionsPicker;

-(IBAction)resultsButton:(UIButton *)sender;

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
    self.optionsArray = @[@"Choose an option below", @"Prime?", @"Prime factors?",@"Find the largest common prime factor"];
    
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


-(void)retrieveLargetPrimeFactor:(NSString *)inputString {
    
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.optionsArray[row];
}


#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.optionsArray.count;
}


@end
