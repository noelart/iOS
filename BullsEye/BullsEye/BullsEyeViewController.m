//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Noel Zahra on 05/01/2014.
//  Copyright (c) 2014 Noel Zahra. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "AboutViewController.h"

@interface BullsEyeViewController ()<UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UILabel *targetLabel;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;

@property (nonatomic, assign) NSUInteger currentValue;
@property (nonatomic, assign) NSUInteger targetValue;
@property (nonatomic, assign) NSUInteger scoreValue;
@property (nonatomic, assign) NSUInteger round;



@end

@implementation BullsEyeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateLabels];
    [self startNewGame];
}

- (void)startNewRound
{
    self.round += 1;
    self.targetValue = 1 + arc4random_uniform(100);
    self.currentValue = 50;
    self.slider.value = self.currentValue;
}

- (void)updateLabels
{
    self.roundLabel.text = [NSString stringWithFormat:@"%d", self.round];
    self.targetLabel.text = [NSString stringWithFormat:@"%d", self.targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.scoreValue];
}

- (void)startNewGame
{
    self.scoreValue = 0;
    self.round = 0;
    [self startNewRound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSUInteger)currentValue
//{
//    return _currentValue;
//}


#pragma mark - UI

- (IBAction)showAlert:(UIButton *)sender
{
    int difference = abs(self.targetValue - self.currentValue);
    int points = 100 - difference;
    
    
    NSString *title;
    if (difference == 0) {
        title = @"Perfect";
        points += 100;
    } else if (difference < 5) {
        title = @"You almost had it!";
        if (difference == 1) {
            points += 50;
        }
    } else if (difference < 10) {
        title = @"Pretty good";
    } else {
        title = @"Not even close";
    }
    
    self.scoreValue += points; //same as self.scoreValue = self.scoreValue + points;
    
    NSString *message = [NSString stringWithFormat:@"Your score is: %d", self.scoreValue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self    //BullsEyeviewController is
                                                                    //the alertView delegate
                                                                    //with delegate:self//
                                          cancelButtonTitle: @"Next"
                                          otherButtonTitles: nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
//  When user closes alertView these methods get called
    [self startNewRound];
    [self updateLabels];
    
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    self.currentValue = lroundf(slider.value);
    NSLog(@"Slider value is : %d", self.currentValue);
}

- (IBAction)startOver:(id)sender
{
    [self startNewGame];
    [self updateLabels];
}

@end
