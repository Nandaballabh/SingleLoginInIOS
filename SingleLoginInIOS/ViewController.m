
//
//  NBViewController.m
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//

#import "NBViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBSession.h>
#import "NBAppDelegate.h"
#import "NBSessionViewController.h"
#import "GPPSignInButton.h"
#import "GPPSignIn.h"
#import "GTLPlusConstants.h"
#import "GTMOAuth2Authentication.h"
#import "GTLServicePlus.h"
#import "GTLQueryPlus.h"
#import "GTLPlusPerson.h"
#import "GTMLogger.h"
#import "NBConstants.h"

@interface NBViewController ()
{
}
@end

@implementation NBViewController

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginStateChanged:) name:FBSessionStateChangedNotification object:nil];
    self.title = @"Single Login";
     self.profilePic.profileID = 0;
    self.signIn = [GPPSignIn sharedInstance];
    self.signIn.clientID = NBCientID;
    self.signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe,nil];
    self.signIn.delegate = self;
    self.signIn.shouldFetchGoogleUserEmail = YES;
    self.signIn.shouldFetchGoogleUserID = YES;
//    if (FBSession.activeSession.isOpen)
//       [[NBAppDelegate instance] openSessionWithAllowLoginUI:NO];
//    else
//        [self.signIn trySilentAuthentication];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshInterfaceBasedOnSignIn
{
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:self.signIn.authentication];
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,GTLPlusPerson *person,NSError *error)
     {
         if (error)
         {
             GTMLoggerError(@"Error: %@", error);
         }
         else
         {
             self.email.text = self.signIn.userEmail;
             self.profileId.text = self.signIn.userID;
             self.name.text = person.displayName;
             self.bday.text = person.birthday;
             self.googleProfileImage = [[UIImageView alloc]initWithFrame:self.profilePic.frame];
             NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString: person.image.url]];
             UIImage *image = [[UIImage alloc]initWithData:data];
             [self.googleProfileImage setImage:image];
             [self.profilePic addSubview:self.googleProfileImage];
         }
     }];
    
    if ([[GPPSignIn sharedInstance] authentication])
    {
        [self.googleSignInButton setTitle:@"            Logout" forState:UIControlStateNormal];
    }
    else
    {
        [self.googleSignInButton setTitle:@"           Login" forState:UIControlStateNormal];
    }
}

-(IBAction)loginwithGoole:(id)sender
{
    if ([[GPPSignIn sharedInstance] authentication])
    {
        [self signOut];
        self.facebookLoginButton.hidden = NO;
        [NBAppDelegate instance].loginType = NBDefaultLogin;
    }
    else
    {
        [NBAppDelegate instance].loginType = NBGoogleLogin;
        [self.signIn authenticate];
    }
    
}

- (void)signOut
{
    [self clearView];
    [self.googleSignInButton setTitle:@"           Login" forState:UIControlStateNormal];
    [self.signIn signOut];
}

- (void)disconnect
{
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"Received error to disconnect");
    }
    
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
    if (error)
    {
    }
    else
    {
        [self refreshInterfaceBasedOnSignIn];
        self.facebookLoginButton.hidden = YES;
    }
}
-(void)clearView
{
    self.name.text = nil;
    self.profileId.text = nil;
    self.email.text = nil;
    self.profilePic.profileID = 0;
    [self.googleProfileImage removeFromSuperview];
    self.bday.text = nil;
}


// facebook Login

-(IBAction)login:(id)sender
{
    if (FBSession.activeSession.isOpen)
    {
        [NBAppDelegate instance].loginType = NBDefaultLogin;
        [[NBAppDelegate instance] closeSession];
    }
    else
    {
        [NBAppDelegate instance].loginType = NBFacebookLogin;
        [[NBAppDelegate instance] openSessionWithAllowLoginUI:YES];
    }
}

-(void)LoginStateChanged:(NSNotification*)notification
{
    if (FBSession.activeSession.isOpen)
    {
        [self.facebookLoginButton setTitle:@"     Logout" forState:UIControlStateNormal];
        self.googleSignInButton.hidden = YES;
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection,id<FBGraphUser> user,NSError *error)
        {
            if(!error)
            {
            self.name.text = user.name;
            self.profileId.text = user.id;
            self.email.text = [user objectForKey:@"email"];
                self.bday.text = user.birthday;
            self.profilePic.profileID = user.id;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!!!" message:@"Failed to fetch user data" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
    else
    {
        [self.facebookLoginButton setTitle:@"    Login" forState:UIControlStateNormal];
        self.googleSignInButton.hidden = NO;
        [self updateView];
    }
}

-(void)updateView
{
    self.name.text = nil;
    self.profileId.text = nil;
    self.email.text = nil;
    self.profilePic.profileID = 0;
    self.bday.text = nil;
    
}
-(IBAction)getSession:(id)sender
{
    NBSessionViewController *ses = [[NBSessionViewController alloc]initWithNibName:@"NBSessionViewController" bundle:nil];
    [ses setGoogleSignIn:self.signIn];
    [self.navigationController pushViewController:ses animated:YES];
}

@end
