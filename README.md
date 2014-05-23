GContact
==========

Deployment:
open GContact.xcodeproj in xcode 5.1 and run

/*********************************************************************************
Summary:
There are three view controllers:

Controller & View:
GContactSignInViewController: this let user input name and password to sign in

GCListContactsViewController: this lists all the user's contact from gmail account 

GCShowcontactsViewController: this show the detail info of a user's contact


Controller to manage the model and issue request:
GContactManager: this uess GDataFeedContact and GDataContacts api from google API to get the contacts from google account.  And it stores the result in an array.  It is a singleton used by the above three view controllers to present the results to the user.

*********************************************************************************/


/********************************************************************************
Given more time the following are the features I would like to add
1. Add table view section in the GCListContactsViewController so that users can navigate through the contacts with alphabetical order list.  This can be done by implementing 
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
This will take half hour to finish

2. Add search bar
When there are lots of lists in the contact, it's better let user to search the contact
through search bar.  This can be done by use regular expresion to match the contact name
eg.
regex = [NSRegularExpression regularExpressionWithPattern:expressionString
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:&error];
This will take 20 mins to add UI and 20 mins to add regular expression to match and 20 for writing test cases


3. Show more information for the contact
Currently in GCShowContactsViewController, it only lists name, email, phone and address.
With more time, additional information such as profile picture can be displayed.

This will take 1 hour to finalize UI and since pictures will be larger than text information, more works needed for handling large information request especially for users with lots of contacts.
********************************************************************************/

/********************************************************************************
Given more time the following are the things I would like to add to make app more robust
1. Dispatch the request for contacts in a seperate thread so that users can navigate the app and do differents things while contacts are being retrieved.  This will take 1-2 hours work to make sure thread safety and add unit test cases.

2. For extreme cases when there are over thousands of contacts being downloaded, I would like to add things to allow app to show the current downloaded contacts to the user.  This can allow users to view contacts already downloaded instead of waiting for very long.

3. I would like to add sqlite db to save the contacts for the user to the local so when there is no internet, users can view offline.  User name and password can be stored in the key chain and encrypted.  For extra security, sqlite db can be encrypted with open SSL cryptography with AES 256 cbc encryption method

********************************************************************************/




