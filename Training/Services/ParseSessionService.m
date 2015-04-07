//
//  ParseSessionService.m
//  Training
//
//  Created by Argentino Ducret on 4/1/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "ParseSessionService.h"

@implementation ParseSessionService

- (PFUser *)currentUser {
    return [PFUser currentUser];
}

@end
