//
//  dyaWebView.h
//  doyouagree
//
//  Created by Tom Berman on 13/08/2013.
//  Copyright (c) 2013 meAndMyself. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dyaWebView : UIViewController

@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *fbUserID;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
- (IBAction)sliderValue:(UISlider *)sender;
- (IBAction)okButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *agreeButton;


@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)share:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@end
