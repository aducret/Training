//
//  NewItem.h
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSDate * creationDate;

+ (NSString *)parseClassName;

@end
