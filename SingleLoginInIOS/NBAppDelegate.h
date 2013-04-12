//
//  NBAppDelegate.h
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NBAppDelegate : UIResponder <UIApplicationDelegate>
extern NSString *const FBSessionStateChangedNotification;


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString *loginType;
@property (strong, nonatomic) UINavigationController *mainNavigation;
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void) closeSession;
+(NBAppDelegate*)instance;
@end
