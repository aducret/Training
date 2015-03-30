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


@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *singUpButton;
@property (weak, nonatomic) IBOutlet UILabel *termsAndConditionsLabel;

- (BOOL) validateEmail: (NSString *) candidate;

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
    
    if( self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 ){
        
        if( ![self validateEmail: self.emailTextField.text] ){
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
