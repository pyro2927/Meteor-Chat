//
//  LoginViewController.m
//  MeteorChat
//
//  Created by Joseph Pintozzi on 7/14/14.
//  Copyright (c) 2014 pyro2927. All rights reserved.
//

#import "LoginViewController.h"
#import "CometChatSessionManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)login:(id)sender{
    CometChatSessionManager *manager = [[CometChatSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlField.text]];
    [manager signInWithUsername:usernameField.text password:passwordField.text completion:^(id object, NSError *error) {
        
    }];
}

@end
