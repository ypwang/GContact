//
//  GContactManager.m
//  GContact
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import "GContactManager.h"
#import "GDataFeedContact.h"
#import "GDataContacts.h"

#define GContactManagerRequestCount 2000

@interface GContactManager ()
@property (nonatomic, strong) GDataServiceTicket *contactRequestTicket;
@property (nonatomic, strong) NSError *contactRequestError;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@end


@implementation GContactManager

static GContactManager *uniqueInstance = nil;

#pragma mark -
#pragma mark Singleton Design Pattern

+ (GContactManager *)sharedInstance {
    @synchronized([GContactManager class]) {
        if (uniqueInstance == nil) {
            uniqueInstance = [[super allocWithZone:NULL] init];
        }
        return uniqueInstance;
    }
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark -
#pragma mark Main Methods

- (void)requestContactsForUserName:(NSString *)userName
						  password:(NSString *)password {
	self.userName = userName;
	self.password = password;
	GDataServiceGoogleContact *service = [self contactService];
	GDataServiceTicket *ticket;
	
	NSURL *feedURL = [GDataServiceGoogleContact contactFeedURLForUserID:kGDataServiceDefaultUser];
	GDataQueryContact *query = [GDataQueryContact contactQueryWithFeedURL:feedURL];
	[query setShouldShowDeleted:FALSE];
	[query setMaxResults:GContactManagerRequestCount];
	
 
	ticket = [service fetchFeedWithQuery:query
								delegate:self
					   didFinishSelector:@selector(contactsRequestTicket:finishedWithFeed:error:)];

	self.contactRequestTicket = ticket;
}

- (GDataServiceGoogleContact *)contactService
{
    static GDataServiceGoogleContact* service = nil;
    
    if (!service) {
        service = [[GDataServiceGoogleContact alloc] init];
        
        [service setShouldCacheResponseData:YES];
        [service setServiceShouldFollowNextLinks:YES];
    }
    
    [service setUserCredentialsWithUsername:self.userName
                                   password:self.password];
    
    return service;
}

- (void)contactsRequestTicket:(GDataServiceTicket *)ticket
			 finishedWithFeed:(GDataFeedContact *)feed
						error:(NSError *)error {
	dispatch_async(dispatch_get_main_queue(), ^{
		if (error) {
			[self.delegate GContactManager:self didFinishRequestForContacts:nil withError:error];
		} else {
			@autoreleasepool {
				NSArray *contacts = [feed entries];
				NSMutableArray *contactsList = [[NSMutableArray alloc] init];
				NSLog(@"Contacts Count: %d ", [contacts count]);
				self.contactsList = nil;
				for (GDataEntryContact *contact in contacts) {
					NSString *contactName = @"";
					contactName = [[[contact name] fullName] contentStringValue];
					if (!contactName) {
						continue;
					}
					
					GDataEmail *email = [[contact emailAddresses] objectAtIndex:0];
					NSString *contactEmailAddress;
					if (email && [email address]) {
						contactEmailAddress = [email address];
					} else {
						contactEmailAddress = @"";
					}
					
					GDataPhoneNumber *phone = [[contact phoneNumbers] objectAtIndex:0];
					NSString *contactPhone;
					if (phone && [phone contentStringValue]) {
						contactPhone = [phone contentStringValue];
					} else {
						contactPhone = @"";
					}
					
					// Address
					GDataStructuredPostalAddress *postalAddress = [[contact structuredPostalAddresses] objectAtIndex:0];
					NSString *contactAddress;
					if (postalAddress) {
						contactAddress = [postalAddress formattedAddress];
					} else {
						contactAddress = @"";
					}
					
					NSArray *keys = [[NSArray alloc] initWithObjects:kGContactName, kGContactEmail, kGContactPhone, kGContactAddress, nil];
					NSArray *objs = [[NSArray alloc] initWithObjects:contactName, contactEmailAddress, contactPhone, contactAddress, nil];
					NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
					
					[contactsList addObject:dict];
				}
				
				NSSortDescriptor *descriptor =
				[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
				[contactsList sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
				
				self.contactsList = [[NSArray alloc] initWithArray:contactsList];
				
				[self.delegate GContactManager:self didFinishRequestForContacts:self.contactsList withError:nil];
			}
		}
	});
}

@end
