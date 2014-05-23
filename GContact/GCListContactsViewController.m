//
//  GCListContactsViewController.m
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "GCListContactsViewController.h"
#import "GCShowContactsViewController.h"
#import "GContactManager.h"

@interface GCListContactsViewController ()

@end


@implementation GCListContactsViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = YES;
    self.tableView.bounces = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.delegate = self;

	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ContactListCell"];
}

- (void) viewWillAppear:(BOOL)inAnimated
{
	[super viewWillAppear:inAnimated];
}

- (void) viewDidAppear:(BOOL)inAnimated
{
	[super viewDidAppear:inAnimated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

#pragma mark - UITableView Delegate & DataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)inTableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)inTableView numberOfRowsInSection:(NSInteger)inSection
{
    return [[[GContactManager sharedInstance] contactsList] count];
}

- (UITableViewCell *) tableView:(UITableView *)inTableView cellForRowAtIndexPath:(NSIndexPath *)inIndexPath
{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ContactListCell"];
   
	NSDictionary *contact = [[[GContactManager sharedInstance] contactsList] objectAtIndex:inIndexPath.row];
	cell.textLabel.text = contact[kGContactName];
	cell.textLabel.textColor = [UIColor darkGrayColor];
	
    return cell;

}

- (void) tableView:(UITableView *)inTableView didSelectRowAtIndexPath:(NSIndexPath *)inIndexPath
{
	NSUInteger index = inIndexPath.row;
	
	GCShowContactsViewController *showContactController = [[GCShowContactsViewController alloc] initWithNibName:@"GCShowContactsViewController" bundle:nil];
	showContactController.index = index;
	[self.navigationController pushViewController:showContactController animated:YES];
	return;
}

@end
