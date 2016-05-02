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
@interface ViewController () <UITextFieldDelegate>

//Define our UI Properties

@property (weak) IBOutlet UITextField *numbersTextField;
@property (weak) IBOutlet UILabel *resultsLabel;
@property (weak) IBOutlet UIPickerView *optionsPicker;

-(IBAction)resultsButton:(UIButton *)sender;

//Make some actions to connect with our picker
-(void)checkIfPrime:(NSString*)inputString;
-(void)retrievePrimeFactors:(NSString*)inputString;
-(void)retrieveLargetPrimeFactor:(NSString*)inputString;

//Array of strings to be defined in the UIPickerView
@property (strong) NSArray *optionsArray;

//Define the brain proerpty here so it can be reset later on
@property (strong)PrimeBrain *brain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Initialize our brain
    self.brain = [[PrimeBrain alloc]init];
    
    //Set the choice options for our UIPickerView
    self.optionsArray = @[@"Choose an option below", @"Prime?",@"Prime factors?",@"Find the largest common prime factor"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)resultsButton:(UIButton *)sender{
    
    
    
    [self.numbersTextField resignFirstResponder];
}

-(void)checkIfPrime:(NSString *)inputString{
    if (<#condition#>) {
        <#statements#>
    }
    
}

-(void)retrievePrimeFactors:(NSString *)inputString{
    
}

-(void)retrieveLargetPrimeFactor:(NSString *)inputString {
    
}
@end
