//
//  GContactSignInViewController.h
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GContactSignInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passowrdField;

- (IBAction)signInAction:(id)sender;

@end
