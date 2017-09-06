//
//  PhychologistViewController.m
//  Phychologist_OC
//
//  Created by 赵笑楠 on 06/07/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import "PhychologistViewController.h"
#import "HappinessViewController.h"

@interface PhychologistViewController ()

@property (nonatomic) int diagnosis;

@end

@implementation PhychologistViewController

@synthesize diagnosis = _diagnosis;

- (void)setAndShowDisgnosis:(int)diagnosis
{
    self.diagnosis = diagnosis;
    //segue
    [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowDiagnosis"])
        [segue.destinationViewController setHappiness:self.diagnosis];
    else if ([segue.identifier isEqualToString:@"Celebrity"])
        [segue.destinationViewController setHappiness:100];
    else if ([segue.identifier isEqualToString:@"Serious"])
        [segue.destinationViewController setHappiness:20];
    else if ([segue.identifier isEqualToString:@"TVKook"])
        [segue.destinationViewController setHappiness:50];
}

- (IBAction)flying
{
    [self setAndShowDisgnosis:85];
}

- (IBAction)apple
{
    [self setAndShowDisgnosis:100];
}

- (IBAction)dragons
{
    [self setAndShowDisgnosis:20];
}

@end
