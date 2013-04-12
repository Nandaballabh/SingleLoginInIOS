//
//  NBViewController.h
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FBProfilePictureView.h>
#import "GPPSignIn.h"
@class GPPSignInButton;

@interface NBViewController : UIViewController<GPPSignInDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *profileId;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UILabel *bday;
@property (weak, nonatomic) IBOutlet GPPSignInButton *googleSignInButton;
@property (retain, nonatomic) GPPSignIn *signIn;
@property (strong, nonatomic) UIImageView *googleProfileImage;
@end