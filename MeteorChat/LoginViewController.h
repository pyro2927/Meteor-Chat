//
//  LoginViewController.h
//  MeteorChat
//
//  Created by Joseph Pintozzi on 7/14/14.
//  Copyright (c) 2014 pyro2927. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    IBOutlet UITextField *usernameField, *passwordField, *urlField;
}

- (IBAction)login:(id)sender;

@end
