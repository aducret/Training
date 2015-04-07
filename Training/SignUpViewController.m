//
//  SingUp.m
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import <UIView+Toast.h>
#import "RegexValidations.h"
#import "MainViewController.h"

@interface SignUpViewController()

@end

@implementation SignUpViewController

- (instancetype)initWithViewModel:(SignUpViewModel *)viewModel {
    self = [super init];
    if (self) {
        _signUpViewModel = viewModel;
    }
    return self;
}

- (IBAction)cancel:(id)sender {
    [self.signUpViewModel cancel];
}

- (void)viewDidLoad {
    [self initializeUI];
}

- (IBAction)signUp:(id)sender {
    [self bindViewModel];
    [self.signUpViewModel signUp];
}

#pragma mark - SignUpViewModel delegate methods

- (void)signUpViewModel:(SignUpViewModel *)viewModel didSignUpUser:(PFUser *)user {
    MainViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle: NULL]
                                       instantiateViewControllerWithIdentifier: @"MainViewController"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)signUpViewModel:(SignUpViewModel *)viewModel failToSignUp:(NSError *)error {
    [self.view makeToast:error.localizedDescription];
}

- (void)signUpViewModelCanceled:(SignUpViewModel *)viewModel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private methods

- (void)bindViewModel {
    self.signUpViewModel.email = self.emailTextField.text;
    self.signUpViewModel.password = self.passwordTextField.text;
    self.signUpViewModel.confirmationPassword = self.confirmPasswordTextField.text;
}

- (void)initializeUI {
    self.emailTextField.placeholder = NSLocalizedString(@"email", nil);
    [self.singupButton setTitle: NSLocalizedString(@"join", nil) forState:UIControlStateNormal];
    [self initializeTermsAndConditionsLabel];
    [self initializePasswordTextField];
    [self initializeConfirmPasswordTextField];
}

- (void)initializePasswordTextField {
    self.passwordTextField.placeholder = NSLocalizedString(@"password", nil);
    self.passwordTextField.secureTextEntry = YES;
}

- (void)initializeConfirmPasswordTextField {
    self.confirmPasswordTextField.placeholder = NSLocalizedString(@"confirmPassword", nil);
    self.confirmPasswordTextField.secureTextEntry = YES;
}

- (void)initializeTermsAndConditionsLabel {
    //FIXME: mejorar
    NSString *termsAndConditionsWrapper = [[NSString alloc] initWithString: NSLocalizedString(@"termsAndConditionsWrapper", nil)];
    NSString *termsAndConditions = [[NSString alloc] initWithString:NSLocalizedString(@"termsAndConditions", nil)];
    NSString *text = [NSString stringWithFormat:@"%@ %@",termsAndConditionsWrapper, termsAndConditions ];
    
    NSDictionary *attribs = @{NSStrokeColorAttributeName: [UIColor redColor]};
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
    
    NSRange range = [text rangeOfString: termsAndConditions];
    [attributedText setAttributes:@{ NSLinkAttributeName: @"www.wolox.com.ar" } range:range];
    
    self.termsAndConditionsLabel.attributedText = attributedText;
}

@end