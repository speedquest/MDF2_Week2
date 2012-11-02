//
//  DetailViewController.h
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController
{
    IBOutlet UILabel *detailTweet;
    IBOutlet UILabel *tweetCreated;
    IBOutlet UILabel *userName;
    IBOutlet UIImageView *profImg;
    IBOutlet UILabel *friends;
    IBOutlet UILabel *desc;
    IBOutlet UILabel *follow;
}

-(void)passText:(NSString*)theText
       passDate:(NSString*)theDate
       passUser:(NSString*)theUser
       passImg:(NSString*)theImageUrl
       passFriends:(NSString*)friendsCount
       passDesc:(NSString*)userDesc
       passFollower:(NSString*)followersCount;

-(IBAction)onClick:(id)sender;

@end
