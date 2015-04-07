//
//  LoginViewModel.h
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginViewController : UIViewController<LogInViewModelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIButton *singUpButton;
@property (weak, nonatomic) IBOutlet UILabel *termsAndConditionsLabel;

@property LoginViewModel *logInViewModel;

- (IBAction)logIn:(id)sender;

- (IBAction)signUp:(id)sender;

@end
