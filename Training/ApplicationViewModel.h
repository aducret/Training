//
//  MainViewModel.h
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "SessionService.h"
#import "LoginViewModel.h"
#import "MainViewModel.h"

@protocol ApplicationViewModelDelegate <NSObject>

- (void)presentLoginViewModel:(LoginViewModel *)loginViewModel;

- (void)presentMainViewModel:(MainViewModel *)mainViewModel;

@end

@interface ApplicationViewModel : NSObject

- (instancetype)initWithDelegate:(id<ApplicationViewModelDelegate>)delegate sessionService:(id<SessionService>)sessionService;

- (void)start;

@end
