//
//  NBSessionViewController.m
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//

#import "NBSessionViewController.h"
#import <FacebookSDK/FBSession.h>
#import "NBAppDelegate.h"
#import "GTMOAuth2Authentication.h"
#import <FacebookSDK/FBAccessTokenData.h>

@interface NBSessionViewController ()

@end

@implementation NBSessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            self.title = @"Access token details";
    }
    return self;
}

- (void)viewDidLoad
{
// facebook token details
    FBAccessTokenData *tokenData = (FBAccessTokenData*)[[FBSession activeSession] accessTokenData];
    NSString *fbaccessToken = tokenData.accessToken;
    NSString *fbrefeshAccessTokendate = [NSString stringWithFormat:@"%@",tokenData.refreshDate];
    NSString *fbtokenexpirationDate = [NSString stringWithFormat:@"%@",tokenData.expirationDate ];
    NSString *facebooktokon = [NSString stringWithFormat:@"AccessToken:\n%@\nTokenexpirationDate:%@\nRefeshAccessToken:\n%@",fbaccessToken,fbtokenexpirationDate,fbrefeshAccessTokendate];
    self.facebookTokenDetails.text =facebooktokon;

    // google plus token details
    
    NSString *accessToken = self.googleSignIn.authentication.accessToken;
    NSString *refeshAccessToken = self.googleSignIn.authentication.refreshToken;
    NSString *tokenexpirationDate = [NSString stringWithFormat:@"%@",self.googleSignIn.authentication.expirationDate ];
    NSString *googletokon = [NSString stringWithFormat:@"AccessToken:\n%@\nTokenexpirationDate:%@\nRefeshAccessToken:\n%@",accessToken,tokenexpirationDate,refeshAccessToken];
    self.googleTokenDetails.text = googletokon;

    [super viewDidLoad];
 
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
