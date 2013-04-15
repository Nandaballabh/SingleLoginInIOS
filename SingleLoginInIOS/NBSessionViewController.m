//
//  NBSessionViewController.m
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.


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
