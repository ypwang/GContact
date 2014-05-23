//
//  GCShowContactsViewController.h
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCShowContactsViewController : UIViewController
@property (nonatomic) NSUInteger index;
@property (weak, nonatomic) IBOutlet UILabel *contactNameFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactEmailFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactAddressFieldLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end
