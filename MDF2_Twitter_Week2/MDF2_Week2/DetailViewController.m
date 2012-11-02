//
//  DetailViewController.m
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import "DetailViewController.h"
#import "UserProfileView.h"
#import "ViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

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

-(void)passText:(NSString*)theText
       passDate:(NSString*)theDate
       passUser:(NSString*)theUser
       passImg:(NSString*)theImageUrl
       passFriends:(NSString*)friendsCount
       passDesc:(NSString*)userDesc
       passFollower:(NSString*)followersCount
{
    self.title = theText;
    NSString *tempText = [[NSString alloc] initWithFormat:@"%@",theText];
    detailTweet.text = @"";
    detailTweet.text =  tempText;
    NSString *tempDate = [[NSString alloc] initWithFormat:@"%@",theDate];
    tweetCreated.text = @"";
    tweetCreated.text =  tempDate;
    NSString *tempUser = [[NSString alloc] initWithFormat:@"%@",theUser];
    userName.text = @"";
    userName.text =  tempUser;
    NSString *tempImg = [[NSString alloc] initWithFormat:@"%@",theImageUrl];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:tempImg]];
    profImg.image = [UIImage imageWithData:data];
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
    NSLog(@"%@", theImageUrl);
    NSLog(@"%@", friendsCount);
    NSLog(@"%@", userDesc);
    NSLog(@"%@", followersCount);
}

-(IBAction)onClick:(id)sender
{
    UserProfileView *ProfileView = [[UserProfileView alloc] initWithNibName:@"UserProfileView" bundle:nil];
    if (ProfileView != nil)
    {
        [self.navigationController pushViewController:ProfileView animated:TRUE];
        
        NSString *theUser = userName.text;
        NSString *friendsCount = friends.text;
        NSString *userDesc = desc.text;
        NSString *followersCount = follow.text;
        
        
        [ProfileView  passUser:theUser passFriends:friendsCount passDesc:userDesc passFollower:followersCount];
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

