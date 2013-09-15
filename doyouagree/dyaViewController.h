//
//  dyaViewController.h
//  doyouagree
//
//  Created by Tom Berman on 13/08/2013.
//  Copyright (c) 2013 meAndMyself. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface dyaViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *codeField;
@property (strong, nonatomic) IBOutlet UILabel *fbUserLabel;


@end
