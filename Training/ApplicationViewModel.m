//
//  MainViewModel.m
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "ApplicationViewModel.h"

#import "ParseSessionService.h"

@interface ApplicationViewModel ()

@property (nonatomic, weak) id<ApplicationViewModelDelegate> delegate;
@property (nonatomic) id<SessionService> sessionService;

@end

@implementation ApplicationViewModel

- (instancetype)initWithDelegate:(id<ApplicationViewModelDelegate>)delegate sessionService:(id<SessionService>)sessionService {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _sessionService = sessionService;
    }
    return self;
}


- (void)start {
    if (self.currentUser) {
        [self.delegate presentMainViewModel:[self createMainViewModel]];
    } else {
        [self.delegate presentLoginViewModel:[self createLoginViewModel]];
    }
}

#pragma mark - Private methods

- (PFUser *)currentUser {
    return [self.sessionService currentUser];
}

- (MainViewModel *)createMainViewModel {
    return [[MainViewModel alloc] init];
}

- (LoginViewModel *)createLoginViewModel {
    return [[LoginViewModel alloc] init];
}

@end
