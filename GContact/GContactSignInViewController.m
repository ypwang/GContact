//
//  GContactSignInViewController.m
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "GContactSignInViewController.h"
#import "GCListContactsViewController.h"
#import "GContactManager.h"

@interface GContactSignInViewController () <GContactManagerDelegate>
@property (strong, nonatomic) UIActivityIndicatorView *loadingActivity;
@end

@implementation GContactSignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIActivityIndicatorView *loadingActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingActivity.color = [UIColor darkGrayColor];
        self.loadingActivity = loadingActivity;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[GContactManager sharedInstance] setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
	self.loadingActivity.frame = CGRectMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0, _loadingActivity.frame.size.width, _loadingActivity.frame.size.height);
    [self.view addSubview:self.loadingActivity];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInAction:(id)sender {
	if (self.loadingActivity.isAnimating) {
        return;
    }
	
	if ([[self.userNameField text] isEqual:@""] || [[self.passowrdField text] isEqual:@""]) {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign In Error"
                                                            message:@"Please enter user name and password."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        NSLog(@"Get Google Contacts");
		[self.loadingActivity startAnimating];
        [[GContactManager sharedInstance] requestContactsForUserName:self.userNameField.text
															password:self.passowrdField.text];
    }

}

#pragma -mark ContactsManagerDelegate
- (void)GContactManager:(GContactManager *)contactManager didFinishRequestForContacts:(NSArray *)contactsList
			  withError:(NSError *)error {
	[self.loadingActivity stopAnimating];
	if (error) {
        NSDictionary *userInfo = [error userInfo];
        NSLog(@"Contacts Fetch error :%@", [userInfo objectForKey:@"Error"]);
        if ([[userInfo objectForKey:@"Error"] isEqual:@"BadAuthentication"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                message:@"Authentication Failed"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                message:@"Failed to get Contacts."
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    } else {
		NSString *message = [[NSString alloc] initWithFormat:@"Fetched %d contacts.", [contactsList count]];
        NSLog(@"%@", message);
		
		GCListContactsViewController *listController = [[GCListContactsViewController alloc] init];
		[self.navigationController pushViewController:listController animated:YES];
	}
}

@end
