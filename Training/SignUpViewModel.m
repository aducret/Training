//
//  SingupViewModel.m
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Parse/Parse.h>
#import "SignUpViewModel.h"
#import "RegexValidations.h"

NSString * const SignUpViewModelErrorDomain = @"com.wolox.training.SignUpViewModelErrorDomain";

@interface SignUpViewModel()

@end

@implementation SignUpViewModel

- (instancetype)initWithDelegate:(id<SignUpViewModelDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)signUp {
    NSError * error = nil;
    if ([self validateCredentials:&error]) {
        PFUser * user = [self createUser];
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * parseError) {
            if (!parseError) {
                [self.delegate signUpViewModel:self didSignUpUser:user];
            } else {
                [self.delegate signUpViewModel:self failToSignUp:parseError];
            }
        }];
    } else {
        [self.delegate signUpViewModel:self failToSignUp:error];
    }
    
}


- (void)cancel {
    [self.delegate signUpViewModelCanceled:self];
}

#pragma mark - Private methods

- (PFUser *)createUser {
    PFUser * user = [PFUser user];
    user.username = self.email;
    user.email = self.email;
    user.password = self.password;
    return user;
}

- (BOOL)validateCredentials:(NSError **)error {
    *error = nil;
    NSDictionary * userInfo;
    
    if (![self.password isEqualToString: self.confirmationPassword]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"passwordsDoNotMatch", nil)};
        *error = [NSError errorWithDomain:SignUpViewModelErrorDomain
                                     code:SignupViewModelErrorPassswordDoesNotMatch
                                 userInfo:userInfo];
    }
    
    if (![self validateConfirmationPasswordLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"missingConfirmationPassword", nil)};
        *error = [NSError errorWithDomain:SignUpViewModelErrorDomain
                                     code:SignupViewModelErrorMissingConfirmationPassword
                                 userInfo:userInfo];
    }
    
    if (![self validatePasswordLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"missingPassword", nil)};
        *error = [NSError errorWithDomain:SignUpViewModelErrorDomain
                                     code:SignupViewModelErrorMissingPassword
                                 userInfo:userInfo];
    }
    
    if (!ValidateEmail(self.email)) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"invalidEmail", nil)};
        *error = [NSError errorWithDomain:SignUpViewModelErrorDomain
                                     code:SignupViewModelErrorInvalidEmail
                                 userInfo:userInfo];
    }
    
    if (![self validateEmailLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"missingEmail", nil)};
        *error = [NSError errorWithDomain:SignUpViewModelErrorDomain
                                     code:SignupViewModelErrorMissingEmail
                                 userInfo:userInfo];
    }
    
    if (![self validateAllFieldsLength]) {
        userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"allFieldsRequired", nil)};
        *error = [NSError errorWithDomain:SignUpViewModelErrorDomain
                                     code:SignupViewModelErrorAllFieldsRequired
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

- (BOOL)validateConfirmationPasswordLength {
    return self.confirmationPassword != nil && self.confirmationPassword.length != 0;
}

- (BOOL)validateAllFieldsLength {
    return [self validateEmailLength] && [self validatePasswordLength] && [self validateConfirmationPasswordLength];
}

@end
