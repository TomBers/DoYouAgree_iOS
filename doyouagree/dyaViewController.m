//
//  dyaViewController.m
//  doyouagree
//
//  Created by Tom Berman on 13/08/2013.
//  Copyright (c) 2013 meAndMyself. All rights reserved.
//

#import "dyaViewController.h"
#import "dyaWebView.h"

@interface dyaViewController () <FBLoginViewDelegate>
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@property (strong, nonatomic) IBOutlet UILabel *fbUserName;

@end

@implementation dyaViewController

@synthesize loggedInUser = _loggedInUser;
@synthesize fbUserName = _fbUserName;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create Login View so that the app will be granted "status_update" permission.
    FBLoginView *loginview = [FBLoginView new];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    loginview.frame = CGRectOffset(loginview.frame, 0, (screenHeight - 75));

    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    
    }

- (void)didReceiveMemoryWarning
{
    NSLog(@"dyaVC : didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.fbUserLabel.text = [NSString stringWithFormat:@"Hello %@", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.loggedInUser = user;
    
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}


- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.loggedInUser=nil;
    self.fbUserLabel.text = [NSString stringWithFormat:@"Logged out"];
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *) theTextField {
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *) theTextField {
	[theTextField resignFirstResponder];
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	[self performSegueWithIdentifier: @"enterCodeSegue" sender: self];
}

//enterCodeSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"enterCodeSegue"]) {
		[self.codeField resignFirstResponder];
		dyaWebView *wbView = segue.destinationViewController;
		wbView.code = self.codeField.text;
		//wbView.fbUserID = [self.loggedInUser id];
        wbView.fbUserID = [self.loggedInUser objectForKey:@"id"];
	}
}

- (IBAction)returnToCodeEntry:(UIStoryboardSegue *)segue
{
	[self.codeField setText:@""];

}


@end
