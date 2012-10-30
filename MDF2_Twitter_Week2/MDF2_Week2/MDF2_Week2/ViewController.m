//
//  ViewController.m
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>  //  Adding the Accounts Framework which allows access to the device Accounts
#import <Twitter/Twitter.h>    //  Adding the Twitter Framework which allows access to the Twitter feeds of the user

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    if (accountStore != nil)
    {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if (accountType != nil)
        {
            [accountStore requestAccessToAccountsWithType:accountType
                                withCompletionHandler:^(BOOL granted, NSError *error)
            {
                if (granted)
                {
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if (twitterAccounts != nil)
                    {
                        ACAccount *currentAcount = [twitterAccounts objectAtIndex:0];
                        if (currentAcount != nil)
                        {
                            NSURL *urlTimeline = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json"];
                            
                            TWRequest *request = [[TWRequest alloc] initWithURL:urlTimeline
                                                                    parameters:nil
                                                                    requestMethod:TWRequestMethodGET];
                            if (request != nil)
                            {
                                request.account = currentAcount;
                                [request performRequestWithHandler:^(NSData *responseData,
                                                                     NSHTTPURLResponse *urlResponse,
                                                                     NSError *error)
                                {
                                    if ([urlResponse statusCode] ==200)
                                    {
                                        NSError *jsonError = nil;
                                        NSArray *info = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:0
                                                         error:&jsonError];
                                        if (info != nil)
                                        {
                                            NSDictionary *tweetItem = [info objectAtIndex:0];
                                            if (tweetItem != nil)
                                            {
                                                NSLog(@"%@", [tweetItem objectForKey:@"text"]);
                                                
                                                //NSLog(@"%@", tweetItem);
                                            }
                                            // NSLog(@"%@", info);
                                        }
                                    }
                                        
                                }];
                            }
                        }
                        // NSLog(@"%@", [twitterAccounts description]);
                    }
                }
                else
                {
                    NSLog(@"The User did not grant access");
                }
            }];
        }
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
