//
//  UserProfileView.m
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import "UserProfileView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface UserProfileView ()

@end

@implementation UserProfileView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)passUser:(NSString*)theUser
       passFriends:(NSString*)friendsCount
       passDesc:(NSString*)userDesc
       passFollower:(NSString*)followersCount
{
    NSString *tempUser = [[NSString alloc] initWithFormat:@"%@",theUser];
    userName.text = @"";
    userName.text =  tempUser;
    NSString *tempFriends = [[NSString alloc] initWithFormat:@"%@",friendsCount];
    friends.text = @"";
    friends.text =  tempFriends;
    NSString *tempDesc = [[NSString alloc] initWithFormat:@"%@",userDesc];
    desc.text = @"";
    desc.text =  tempDesc;
    NSString *tempFollow = [[NSString alloc] initWithFormat:@"%@",followersCount];
    follow.text = @"";
    follow.text =  tempFollow;
    NSLog(@"%@", theUser);
    NSLog(@"%@", friendsCount);
    NSLog(@"%@", userDesc);
    NSLog(@"%@", followersCount);}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
