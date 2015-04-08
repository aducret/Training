//
//  LoginModelView.m
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "LoginViewModel.h"
#import <Parse/Parse.h>
#import "RegexValidations.h"

NSString * const LogInViewModelErrorDomain = @"com.wolox.training.LogInViewModelErrorDomain";

@implementation LoginViewModel

- (instancetype)initWithDelegate:(id<LogInViewModelDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)logIn {
    NSError * error;
    if ([self validateCredentials:&error]) {
        [PFUser logInWithUsernameInBackground:self.email password:self.password block: ^(PFUser *user, NSError *parseError) {
            if (user) {
                [self.delegate logInViewModel:self didLogInUser:user];
            } else {
                [self.delegate logInViewModel:self failToLogIn:parseError];
            }
        }];
    } else {
        [self.delegate logInViewModel:self failToLogIn:error];
    }
}

- (void)signUp {
    SignUpViewModel * viewModel = [[SignUpViewModel alloc] init];
    [self.delegate presentSignUpViewModel:viewModel];
}

#pragma mark - Private methods

- (BOOL)validateCredentials:(NSError **)error{
    *error = nil;
    NSDictionary * userInfo;
    
    if (![self validatePasswordLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"missingPassword", nil)};
        *error = [NSError errorWithDomain:LogInViewModelErrorDomain
                                     code:LogInViewModelErrorMissingPassword
                                 userInfo:userInfo];
    }
    
    if (!ValidateEmail(self.email)) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"invalidEmail", nil)};
        *error = [NSError errorWithDomain:LogInViewModelErrorDomain
                                     code:LogInViewModelErrorInvalidEmail
                                 userInfo:userInfo];
    }
    
    if (![self validateEmailLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"missingEmail", nil)};
        *error = [NSError errorWithDomain:LogInViewModelErrorDomain
                                     code:LogInViewModelErrorMissingEmail
                                 userInfo:userInfo];
    }
    
    if (![self validateAllFieldsLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"allFieldsRequired", nil)};
        *error = [NSError errorWithDomain:LogInViewModelErrorDomain
                                     code:LogInViewModelErrorAllFieldsRequired
                                 userInfo:userInfo];
    }
    
    return *error == nil;
}

- (BOOL)validateEmailLength {
    return self.email != nil && self.email.length != 0;
}

- (BOOL)validatePasswordLength {
    return self.password != nil && self.password.length != 0;
}

- (BOOL)validateAllFieldsLength {
    return [self validateEmailLength] && [self validatePasswordLength];
}

@end
