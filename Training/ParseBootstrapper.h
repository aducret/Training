//
//  ParseBootstraper.h
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseBootstrapper : NSObject

@property (nonatomic, retain) NSString * applicationId;
@property (nonatomic, retain) NSString * clientKey;

+ (instancetype)defaultBootstraper;

- (instancetype)initWithApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;

- (void)bootstrap;

@end
