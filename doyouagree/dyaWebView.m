//
//  dyaWebView.m
//  doyouagree
//
//  Created by Tom Berman on 13/08/2013.
//  Copyright (c) 2013 meAndMyself. All rights reserved.
//

#import "dyaWebView.h"
#import <FacebookSDK/FacebookSDK.h>

@interface dyaWebView ()

@property (strong, nonatomic) NSMutableDictionary *postParams;

@end

@implementation dyaWebView
NSString *domain = @"http://www.doyouagree.co.uk/";
float val =0.5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.slider setEnabled:TRUE];
        [self.shareButton setEnabled:FALSE];
        [self.shareButton setHidden:TRUE];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.code isEqualToString:@""]) {
     self.code =@"BrokeLink";
    }
    NSString* url = [NSString stringWithFormat:@"%@%@.html",domain,self.code];
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    [_webView loadRequest:request];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValue:(UISlider *)sender {
    
    val = sender.value;
    NSString *val = [NSString stringWithFormat:@"I agree : %d%%", (int) (sender.value * 100) ];
    self.valueLabel.text = val;
    
}

- (IBAction)okButton:(UIButton *)sender {
    NSString* url = [NSString stringWithFormat:@"%@storeResponse.php?code=%@&value=%f&user=%@",domain,self.code,val,self.fbUserID];
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    [_webView loadRequest:request];
    
    [self.slider setEnabled:FALSE];
    
    [self.shareButton setEnabled:TRUE];
    [self.shareButton setHidden:FALSE];
    
}

- (IBAction)share:(UIButton *)sender {
    
    NSString *pageLink = [NSString stringWithFormat:@"%@storeResponse.php?code=%@",domain,self.code];
    NSString *imgLink = [NSString stringWithFormat:@"%@dya_logo.png",domain];
    
    self.postParams = [@{
                                              @"link" : pageLink,
                                              @"picture" : imgLink,
                                              @"name" : @"Do You Agree",
                                              @"caption" : @"Do you agree with ...",
                                              @"description" : @"The mobile app that makes it easy to see if you agree"
                                              } mutableCopy];

    
    if ([FBSession.activeSession.permissions
         indexOfObject:@"publish_actions"] == NSNotFound) {
        // No permissions found in session, ask for it
        [FBSession.activeSession
         requestNewPublishPermissions:@[@"publish_actions"]
         defaultAudience:FBSessionDefaultAudienceFriends
         completionHandler:^(FBSession *session, NSError *error) {
             if (!error) {
                 // If permissions granted, publish the story
                 [self publishStory];
             }
         }];
    } else {
        // If permissions present, publish the story
        [self publishStory];
    }
    
    
    
}



- (void)publishStory
{
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:self.postParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         } else {
             alertText = [NSString stringWithFormat:
                          @"Thanks for sharing"];
         }
         // Show the result in an alert
         [[[UIAlertView alloc] initWithTitle:@"Posted"
                                     message:alertText
                                    delegate:self
                           cancelButtonTitle:@"OK!"
                           otherButtonTitles:nil]
          show];
     }];
}

@end
