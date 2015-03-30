//
//  SingUp.m
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "SingUpViewController.h"
#import <Parse/Parse.h>
#import <UIView+Toast.h>

@interface SingUpViewController()

- (BOOL) validateEmail: (NSString *) candidate;

@end

@implementation SingUpViewController


- (void)viewDidLoad{
    [self.emailTextField setPlaceholder: NSLocalizedString(@"email", nil)];
    [self.passwordTextField setPlaceholder: NSLocalizedString(@"password", nil)];
    [self.confirmPasswordTextField setPlaceholder: NSLocalizedString(@"confirmPassword", nil)];
    
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

    //Setting singupButton
    [self.singupButton setTitle: NSLocalizedString(@"join", nil) forState:UIControlStateNormal];
}

- (IBAction)singUp:(id)sender {
    
    if(self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0){
    
        if(![self validateEmail:self.emailTextField.text]){
            [self.view makeToast:NSLocalizedString(@"invalidEmail", nil)];
            return;
        }
        
        if(![self.passwordTextField.text isEqualToString: self.confirmPasswordTextField.text]){
            [self.view makeToast: NSLocalizedString(@"passwordsDoNotMatch", nil)];
            return;
        }
        
        

        PFUser *user = [PFUser user];
        user.username = self.emailTextField.text;
        user.email = self.emailTextField.text;
        user.password = self.passwordTextField.text;
        
        //Sign up
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Registrado!
            } else {
                NSString *errorString = [error userInfo][@"error"];
                [self.view makeToast:errorString];
            }
        }];
    } else {
        //All field empty
        [self.view makeToast: NSLocalizedString(@"allRequired", nil)];
    }
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end