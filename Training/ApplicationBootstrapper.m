//
//  ApplicationBootstrapper.m
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "ApplicationBootstrapper.h"
#import "ApplicationViewModel.h"
#import "ParseSessionService.h"
#import "ParseBootstrapper.h"
#import "LoginViewController.h"

@interface ApplicationBootstrapper ()<ApplicationViewModelDelegate>

@property (nonatomic) UIWindow * window;
@property (nonatomic) ApplicationViewModel * applicationViewModel;
@property (nonatomic) id<SessionService> sessionService;

@end

@implementation ApplicationBootstrapper

- (instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        _window = window;
        _sessionService = [[ParseSessionService alloc] init];
        _applicationViewModel = [[ApplicationViewModel alloc] initWithDelegate:self sessionService:self.sessionService];
    }
    return self;
}

- (void)bootstrap {
    [[ParseBootstrapper defaultBootstraper] bootstrap];
    [self.applicationViewModel start];
}

#pragma mark - ApplicationViewModelDelegate methods

- (void)presentLoginViewModel:(LoginViewModel *)loginViewModel {
    LoginViewController * loginViewController = [[UIStoryboard storyboardWithName:@"LoginSignup" bundle: NULL]
                                                 instantiateViewControllerWithIdentifier: @"LoginViewController"];
    loginViewController.logInViewModel = loginViewModel;
    loginViewModel.delegate = loginViewController;
    self.window.rootViewController = loginViewController;
}

- (void)presentMainViewModel:(MainViewModel *)mainViewModel {
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle: NULL]
                                      instantiateViewControllerWithIdentifier: @"MainViewController"];
}

@end
