//
//  LoginModelView.h
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "SignUpViewModel.h"

extern NSString * const LogInViewModelErrorDomain;

typedef enum : NSUInteger {
    LogInViewModelErrorAllFieldsRequired,
    LogInViewModelErrorMissingEmail,
    LogInViewModelErrorMissingPassword,
    LogInViewModelErrorInvalidEmail
} LogInViewModelError;

@class LoginViewModel;

@protocol LogInViewModelDelegate <NSObject>

- (void)logInViewModel:(LoginViewModel *)viewModel didLogInUser:(PFUser *)user;

- (void)logInViewModel:(LoginViewModel *)viewModel failToLogIn:(NSError *)error;

- (void)presentSignUpViewModel:(SignUpViewModel *)signUpViewModel;

@end

@interface LoginViewModel : NSObject

@property (nonatomic) NSString * email;
@property (nonatomic) NSString * password;
@property (nonatomic, weak) id<LogInViewModelDelegate> delegate;

- (instancetype)initWithDelegate:(id<LogInViewModelDelegate>)delegate;

- (void)logIn;

- (void)signUp;

@end
