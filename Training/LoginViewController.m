//
//  LoginViewModel.m
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "LoginViewController.h"

#import <UIView+Toast.h>
#import "RegexValidations.h"
#import "SignUpViewController.h"
#import "SignUpViewModel.h"
#import "MainViewController.h"

@interface LoginViewController()

@property (nonatomic) NSNotificationCenter * notificationCenter;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [self initializeUI];
    self.notificationCenter = [NSNotificationCenter defaultCenter];
}

- (void)viewWillAppear:(BOOL)animated {
    [self subscribeToKeyboardEvents];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self unsubscribeFromKeyboardEvents];
}

- (IBAction)logIn:(id)sender {
    [self bindViewModel];
    [self.logInViewModel logIn];
}

- (IBAction)signUp:(id)sender {
    [self.logInViewModel signUp];
}

#pragma mark - LogInViewModel delegate methods

- (void)logInViewModel:(LoginViewModel *)viewModel didLogInUser:(PFUser *)user {
    
    MainViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle: NULL]
                                        instantiateViewControllerWithIdentifier: @"MainViewController"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)logInViewModel:(LoginViewModel *)viewModel failToLogIn:(NSError *)error {
    [self.view makeToast:error.localizedDescription];
}

- (void)presentSignUpViewModel:(SignUpViewModel *)signUpViewModel {
    SignUpViewController * controller = [[UIStoryboard storyboardWithName:@"LoginSignup" bundle: NULL]
                                         instantiateViewControllerWithIdentifier: @"SignUpViewController"];
    controller.signUpViewModel = signUpViewModel;
    signUpViewModel.delegate = controller;
    
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Private methods

- (void)subscribeToKeyboardEvents {
    [self.notificationCenter addObserver:self
                                selector:@selector(keyboardWillAppear:)
                                    name:UIKeyboardWillShowNotification object:nil];
    [self.notificationCenter addObserver:self
                                selector:@selector(keyboardWillDisappear:)
                                    name:UIKeyboardWillHideNotification object:nil];
}

- (void)unsubscribeFromKeyboardEvents {
    [self.notificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [self.notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillAppear:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect endFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.view.transform = CGAffineTransformMakeTranslation(0, -endFrame.size.height);
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    [self.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
}

- (void)bindViewModel {
    self.logInViewModel.email = self.emailTextField.text;
    self.logInViewModel.password = self.passwordTextField.text;
}

- (void)initializeUI {
    self.logoImage.image = [UIImage imageNamed:@"login_logo"];
    self.emailTextField.placeholder = NSLocalizedString(@"email", nil);
    [self initializePasswordTextField];
    [self.logInButton setTitle: NSLocalizedString(@"logIn", nil) forState:(UIControlStateNormal)];
    [self.singUpButton setTitle: NSLocalizedString(@"singUp", nil) forState:(UIControlStateNormal)];
    [self initializeTermsAndConditionsLabel];
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

- (void)initializePasswordTextField {
    self.passwordTextField.placeholder = NSLocalizedString(@"password", nil);
    self.passwordTextField.secureTextEntry = YES;
}

@end
