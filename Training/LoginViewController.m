//
//  LoginViewModel.m
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <UIView+Toast.h>
#import "RegexValidations.h"

@interface LoginViewController()



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [self.logoImage setImage: [UIImage imageNamed:@"login_logo"]];
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
    
    if( self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 ){
        
        if( ![RegexValidations validateEmail: self.emailTextField.text] ){
            [self.view makeToast:NSLocalizedString(@"invalidEmail", nil)];
            return;
        }

        //Loggin
        [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
            if (user) {
                NSLog(@"login");
            } else {
                //error
                [self.view makeToast:NSLocalizedString(@"invalidLogIn", nil)];
            }
        }];
    }
    else {
        //All fields empty
        [self.view makeToast:NSLocalizedString(@"allRequired", nil)];
    }
}

-(void)unWindSegue:(UIStoryboardSegue *)sender{
    
}

@end
