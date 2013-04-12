//
//  NBSessionViewController.h
//  SingleLoginInIOS
//
//  Created by Nanda Ballabh on 10/04/13.
//  Copyright (c) 2013 Nanda Ballabh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPPSignIn.h"

@interface NBSessionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *googleTokenDetails;
@property (weak, nonatomic) IBOutlet UITextView *facebookTokenDetails;
@property (weak, nonatomic) GPPSignIn *googleSignIn;
@end
