//
//  ApplicationBootstrapper.h
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ApplicationBootstrapper : NSObject

- (instancetype)initWithWindow:(UIWindow *)window;

- (void)bootstrap;

@end
