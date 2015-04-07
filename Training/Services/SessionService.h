//
//  SessionService.h
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Parse/Parse.h>

@protocol SessionService <NSObject>

- (PFUser *)currentUser;

@end
