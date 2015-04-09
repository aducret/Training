//
//  SingUp.h
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewModel.h"

@interface SignUpViewController : UIViewController<SignUpViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *termsAndConditionsLabel;
@property (weak, nonatomic) IBOutlet UIButton *singupButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (nonatomic) SignUpViewModel * signUpViewModel;

- (instancetype)initWithViewModel:(SignUpViewModel *)viewModel;

- (IBAction)cancel:(id)sender;

@end
