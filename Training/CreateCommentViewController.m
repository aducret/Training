//
//  CreateCommentViewController.m
//  Training
//
//  Created by Argentino Ducret on 4/10/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIView+Toast.h>

#import "Comment.h"
#import "CreateCommentViewController.h"
#import "ParseSessionService.h"


@interface CreateCommentViewController()

@end

@implementation CreateCommentViewController

- (instancetype)initWithDelegate:(id<CreateCommentViewControllerProtocol>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)setImage:(id)sender {
    
}

- (IBAction)saveComment:(id)sender {
    if ([self validateFilds]) {
        Comment * comment = [[Comment alloc] initWithClassName:@"Comment"];
        comment.text = self.descriptionTextField.text;
        ParseSessionService * parseService = [[ParseSessionService alloc] init];
        comment.email = parseService.currentUser.email;
        comment.like = NO;
        [comment saveEventually:^(BOOL succeded, NSError *error){
            if (!succeded) {
                [self.view makeToast:NSLocalizedString(@"serverError", nil)];
            } else {
                [self.delegate createCommentViewControllerCanceled: self];
            }
        }];
    }
}

- (IBAction)cancel:(id)sender {
    [self.delegate createCommentViewControllerCanceled:self];
}

#pragma mark - Private Methods

- (BOOL)validateFilds {
    if (self.descriptionTextField.text.length == 0) {
        [self.view makeToast:NSLocalizedString(@"missingDescription", nil)];
        return NO;
    }
    
    if (self.descriptionTextField == nil || self.descriptionTextField.text.length > 250) {
        [self.view makeToast:NSLocalizedString(@"descriptionLengthError", nil)];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
