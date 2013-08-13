//
//  dyaWebView.m
//  doyouagree
//
//  Created by Tom Berman on 13/08/2013.
//  Copyright (c) 2013 meAndMyself. All rights reserved.
//

#import "dyaWebView.h"

@interface dyaWebView ()

@end

@implementation dyaWebView

float val =0.5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* url = [NSString stringWithFormat:@"http://www.pic-card.me/pm/%@.html",self.code];
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
    NSString *val = [NSString stringWithFormat:@"%d%%", (int) (sender.value * 100) ];
    self.valueLabel.text = val;
    
}

- (IBAction)okButton:(UIButton *)sender {
    NSString* url = [NSString stringWithFormat:@"http://www.pic-card.me/pm/storeResponse.php?code=%@&value=%f&user=%@",self.code,val,self.fbUserID];
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    [_webView loadRequest:request];
}
@end
