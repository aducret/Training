//
//  SingupViewModel.h
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

extern NSString * const SignUpViewModelErrorDomain;

typedef enum : NSUInteger {
    SignupViewModelErrorMissingEmail,
    SignupViewModelErrorMissingPassword,
    SignupViewModelErrorPassswordDoesNotMatch,
    SignupViewModelErrorInvalidEmail
} SignupViewModelError;

@class SignUpViewModel;

@protocol SignUpViewModelDelegate <NSObject>

- (void)signUpViewModel:(SignUpViewModel *)viewModel didSignUpUser:(PFUser *)user;

- (void)signUpViewModel:(SignUpViewModel *)viewModel failToSignUp:(NSError *)error;

- (void)signUpViewModelCanceled:(SignUpViewModel *)viewModel;

@end

@interface SignUpViewModel : NSObject

@property (nonatomic) NSString * email;
@property (nonatomic) NSString * password;
@property (nonatomic) NSString * confirmationPassword;
@property (nonatomic, weak) id<SignUpViewModelDelegate> delegate;

- (instancetype)initWithDelegate:(id<SignUpViewModelDelegate>)delegate;

- (void)signUp;

- (void)cancel;

@end
