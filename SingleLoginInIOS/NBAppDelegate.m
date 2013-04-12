//
//  NBAppDelegate.m
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//

#import "NBAppDelegate.h"
#import <FacebookSDK/FBSession.h>
#import "NBViewController.h"
#import "GPPURLHandler.h"
#import "NBConstants.h"

@implementation NBAppDelegate

NSString *const FBSessionStateChangedNotification =NBFBSessionStateChangedNotification;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NBViewController *viewController = [[NBViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.mainNavigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    self.window.rootViewController = self.mainNavigation;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * Callback for session changes.facebook
 */
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
            if (!error)
            {
                
            }
            break;
            
        case FBSessionStateClosed:
            
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];
    
    if (error)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    NSArray *permissions = [[NSArray alloc]initWithObjects:@"email",@"user_birthday",nil];
    return [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:allowLoginUI completionHandler:^(FBSession *session,FBSessionState state,NSError *error)
        {
            [self sessionStateChanged:session state:state error:error];
        }];
}
/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */

- (void) closeSession
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

// google plus

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url   sourceApplication: (NSString *)sourceApplication annotation: (id)annotation
{
    if ([self.loginType isEqual:NBFacebookLogin])
         return [FBSession.activeSession handleOpenURL:url];
    
    if ([self.loginType isEqual:NBGoogleLogin])
    {
        return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
    }
    return YES;
}


+(NBAppDelegate*)instance
{
    return [UIApplication sharedApplication].delegate;
}
@end
