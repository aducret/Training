//
//  CreateCommentViewController.h
//  Training
//
//  Created by Argentino Ducret on 4/10/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreateCommentViewController;

@protocol CreateCommentViewControllerProtocol <NSObject>

- (void)createCommentViewControllerCanceled:(CreateCommentViewController *) viewController;

@end

@interface CreateCommentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton * ImageButton;
@property (weak, nonatomic) IBOutlet UITextField * descriptionTextField;

@property (nonatomic, weak) id<CreateCommentViewControllerProtocol> delegate;

- (instancetype)initWithDelegate:(id<CreateCommentViewControllerProtocol>)delegate;

@end