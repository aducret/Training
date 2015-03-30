//
//  SingUp.m
//  Training
//
//  Created by Argentino Ducret on 3/27/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "SingUpViewController.h"
#import <Parse/Parse.h>

@implementation SingUpViewController

- (IBAction)singUp:(id)sender {
    
    if(self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0){
        
        if(![self.passwordTextField.text isEqualToString: self.confirmPasswordTextField.text]){
            //TODO: mostrar error.
            return;
        }

        PFUser *user = [PFUser user];
        user.username = self.emailTextField.text;
        user.email = self.emailTextField.text;
        user.password = self.passwordTextField.text;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Registrado!
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                //TODO: Mostrar error.
            }
        }];
    }
}

@end
