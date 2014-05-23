//
//  GCShowContactsViewController.m
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "GCShowContactsViewController.h"
#import "GContactManager.h"

@interface GCShowContactsViewController ()
@property (nonatomic, strong) NSDictionary *contactInfo;
@end

@implementation GCShowContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_contactInfo = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIndex:(NSUInteger)index {
	NSArray *contactList = [[GContactManager sharedInstance] contactsList];
	if (index < [contactList count]) {
		_index = index;
		self.contactInfo = contactList[index];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	self.nameLabel.text = self.contactInfo[kGContactName];
	self.phoneLabel.text = self.contactInfo[kGContactPhone];
	self.emailLabel.text = self.contactInfo[kGContactEmail];
	self.addressLabel.text = self.contactInfo[kGContactAddress];
	self.addressLabel.numberOfLines = 0;
	[self.addressLabel sizeToFit];
}

@end
