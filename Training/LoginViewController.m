//
//  LoginViewModel.m
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>


@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *singUpButton;
@property (weak, nonatomic) IBOutlet UILabel *termsAndConditionsLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    //[self.frontImage setImage:];
    [self.logoImage setImage: [UIImage imageNamed:@"header_logo"]];
    self.logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.emailTextField setPlaceholder: NSLocalizedString(@"email", nil)];
    [self.passwordTextField setPlaceholder: NSLocalizedString(@"password", nil)];
    [self.logInButton setTitle: NSLocalizedString(@"logIn", nil) forState:(UIControlStateNormal)];
    [self.singUpButton setTitle: NSLocalizedString(@"singUp", nil) forState:(UIControlStateNormal)];
    
    //Setting termsAnsConditionsLabel
    NSString *termsAndConditionsWrapper = [[NSString alloc] initWithString: NSLocalizedString(@"termsAndConditionsWrapper", nil)];
    NSString *termsAndConditions = [[NSString alloc] initWithString:NSLocalizedString(@"termsAndConditions", nil)];
    NSString *text = [NSString stringWithFormat:@"%@ %@",termsAndConditionsWrapper, termsAndConditions ];
    
    NSDictionary *attribs = @{
                            NSStrokeColorAttributeName: [UIColor redColor]
                            };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
    
    NSRange range = [text rangeOfString: termsAndConditions];
    [attributedText setAttributes:@{ NSLinkAttributeName: @"www.wolox.com.ar" } range:range];
    
    self.termsAndConditionsLabel.attributedText = attributedText;
}

- (IBAction)logIn:(id)sender {
    [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            NSLog(@"login");
        } else {
            //error
            NSLog(@"error");
        }
    }];
}

@end
