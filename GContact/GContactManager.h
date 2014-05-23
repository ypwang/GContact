//
//  GContactManager.h
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGContactName @"name"
#define kGContactEmail @"email"
#define kGContactPhone @"phone"
#define kGContactAddress @"address"

@class GContactManager;

@protocol GContactManagerDelegate <NSObject>

- (void)GContactManager:(GContactManager *)contactManager didFinishRequestForContacts:(NSArray *)contactsList
			  withError:(NSError *)error;
@end

@interface GContactManager : NSObject
/*! The one and only way to get a instance of CZDefaultSettings. */
+ (GContactManager *)sharedInstance;

@property (nonatomic, strong) NSArray *contactsList;
@property (nonatomic, weak) id<GContactManagerDelegate> delegate;

- (void)requestContactsForUserName:(NSString *)userName
						  password:(NSString *)password;
@end
