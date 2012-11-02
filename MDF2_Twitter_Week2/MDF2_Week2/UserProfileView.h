//
//  UserProfileView.h
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import "AppDelegate.h"

@interface UserProfileView : UIViewController
{
    IBOutlet UILabel *userName;
    IBOutlet UILabel *friends;
    IBOutlet UILabel *desc;
    IBOutlet UILabel *follow;
}
-(void)passUser:(NSString*)theUser
       passFriends:(NSString*)friendsCount
       passDesc:(NSString*)userDesc
       passFollower:(NSString*)followersCount;

@end
