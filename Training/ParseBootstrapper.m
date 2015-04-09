//
//  ParseBootstraper.m
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Parse/Parse.h>
#import "ParseBootstrapper.h"

@implementation ParseBootstrapper

@synthesize applicationId = _applicationId;
@synthesize clientKey = _clientKey;

#pragma mark - Singleton methods

+ (instancetype)defaultBootstraper {
    static ParseBootstrapper * sharedBootstraper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBootstraper = [[self alloc] init];
    });
    return sharedBootstraper;
}

- (instancetype)initWithApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey {
    if (self = [super init]) {
        _applicationId = [[NSString alloc] initWithString:applicationId];
        _clientKey = [[NSString alloc]initWithString:clientKey];
    }
    return self;
}

- (void)bootstrap {
    [Parse enableLocalDatastore];
    
    [Parse setApplicationId:@"G6OmtROOQOtS3AyvUpuhU26M9vVZD4G1R9hhf11f"
                  clientKey:@"42b5qJ8m0kFyqksuOt5boqyi3jc5h0c7RBe1naNh"];
}
@end
