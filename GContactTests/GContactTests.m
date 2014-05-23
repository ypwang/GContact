//
//  GContactTests.m
//  GContactTests
//
//  Created by Mike Wang on 2014-05-23.
//  Copyright (c) 2014 wang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GContactManager.h"

@interface GContactTests : XCTestCase <GContactManagerDelegate>
@property (atomic) BOOL shouldKeepRunning;
@property (atomic) BOOL shouldFail;
@end

@implementation GContactTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testContactManager
{
	[[GContactManager sharedInstance] setDelegate:self];
	[[GContactManager sharedInstance] requestContactsForUserName:@"kinetic.cafe.2014@gmail.com" password:@"mindbeatsmoney"];
	
	
	self.shouldKeepRunning = YES;
	self.shouldFail = NO;
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	while (self.shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
	
	[[GContactManager sharedInstance] requestContactsForUserName:@"kinetic.cafe.2014@gmail.com" password:@""];
	
	
	self.shouldKeepRunning = YES;
	self.shouldFail = YES;
	theRL = [NSRunLoop currentRunLoop];
	while (self.shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

#pragma -mark ContactsManagerDelegate
- (void)GContactManager:(GContactManager *)contactManager didFinishRequestForContacts:(NSArray *)contactsList
			  withError:(NSError *)error {
	self.shouldKeepRunning = NO;
	XCTAssert((self.shouldFail && error) || (!self.shouldFail && !error), @"Failed to request contacts");
}
@end
