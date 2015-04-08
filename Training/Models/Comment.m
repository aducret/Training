//
//  NewItem.m
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Parse/Parse.h>

#import "Comment.h"

@implementation Comment

@dynamic email;
@dynamic text;
@dynamic creationDate;

+ (void)load{
    [self registerSubclass];
}

+ (NSString *)parseClassName{
    return @"Comment";
}

@end
