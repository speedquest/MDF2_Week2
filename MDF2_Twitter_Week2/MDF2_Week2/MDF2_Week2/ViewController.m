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
#import "CustomCellView.h"
#import "DetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize twitterText, twitterTime, twitterTableView;

- (void)viewDidLoad
{
    //  Loading the Nav Bar art the top in Black
    self.navigationController.navigationBar.tintColor= [UIColor blackColor];
    
    //  Adding the 'New Tweet' button on the right side
    UIBarButtonItem *newTweet =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = newTweet;
    
    //  Adding the 'Refresh' button on the left side
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshItem:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    
    // Overlaying the 'Loading' view over top of the TableView until the TableView is refreshed
    loadingTweetsScreen.frame = CGRectMake(0.0f, 0.0f, loadingTweetsScreen.frame.size.width, loadingTweetsScreen.frame.size.height);

    //  Runs theTwitter for inital population of the table
    [self theTwitter];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


//  The actual loading of the Twitter posts from the Twitter Framework

-(void)theTwitter
{
    [self performSelectorInBackground:@selector(loadingPopUp) withObject:self];
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
                                      //  If a valid web connection is made
                                      if ([urlResponse statusCode] ==200)
                                      {
                                          NSError *jsonError = nil;
                                          twitterText = [NSJSONSerialization JSONObjectWithData:responseData
                                                                              options:0
                                                                              error:&jsonError];
                                          [twitterTableView reloadData];
                                          
                                          // Dismiss the 'Wait' dialog screen
                                          [self dismissLoadingPopup];
                                          
                                          //  If there is valid data log it out for test
                                          if (twitterText != nil)
                                          {
                                              NSDictionary *tweetItem = [twitterText objectAtIndex:0];
                                              if (tweetItem != nil)
                                              {
                                                  NSLog(@"%@", [twitterText description]);
                                                  
                                              }
                                          }
                                      }
                                      
                                  }];
                             }
                         }
                     }
                 }
                 else
                 {
                     NSLog(@"The User did not grant access");
                 }
             }];
        }
    }
}

//  Function to perform the animated 'Loading' screen over top of the existing view


-(void) loadingPopUp
{
    loading = [[UIView alloc] initWithFrame:CGRectMake(10.0f,10.0f, 300.0f, 400.0f)];
    loading.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f];
    
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activity.center = self.view.center;
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 50.0f, 300.0f, 45.0)];
    loadingLabel.text = @"Tweets are being loaded!";
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    loadingLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loading];
    [loading addSubview:loadingLabel];
    [loading addSubview:activity];
    [activity startAnimating];
    
}

//  Function to pull the 'Loading' screen down from the view
-(void) dismissLoadingPopup
{
    [loading removeFromSuperview];
    
}


//  Function to 'Refresh' the tweets
- (void)refreshItem:(id)sender
{
    NSLog(@"Refresh button is working");
    [self theTwitter];
}

//  Function to 'Add new tweets'
- (void)addItem:(id)sender
{
    TWTweetComposeViewController *createTweet = [[TWTweetComposeViewController alloc] init];
    if (createTweet != nil)
    {
        [createTweet setInitialText:@"Posted from"];
        
        [self presentViewController:createTweet animated:YES completion:nil];
    }
    
    NSLog(@"Add button is working");
}

//  Establishing the number of rows in the table based on the number of tweets
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (twitterText != nil)
    {
        return [twitterText count];
    }
    return 0;
}

//  The actual population of the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView" owner:self options:nil];
    CustomCellView *cell = (CustomCellView *)[nib objectAtIndex:0];
    if (cell != nil)
    {
        NSDictionary *tweetDictionary = [twitterText objectAtIndex:indexPath.row];
        if (tweetDictionary != nil)
        {
            cell.tweetLabel.text = (NSString*)[tweetDictionary objectForKey:@"text"];
            //  Set the variable df to allow it to format future data
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            //  Format the date the df will contain
            [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
            
            //  Set the variable date to the date extracted from the object at the current key
            NSDate *date = [df dateFromString:[tweetDictionary objectForKey:@"created_at"]];
            [df setDateFormat:@"MMM dd yyyy @ hh:mm a"];
            NSString *dateStr = [df stringFromDate:date];
            //  Set the dateSTR to the value of the current timeStamp
            cell.timeStampLabel.text = dateStr;
            
            
            NSString *imageUrl = [[tweetDictionary objectForKey:@"user"] objectForKey:@"profile_image_url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            cell.imageView.image = [UIImage imageWithData:data];
            
        }
        return cell;
    }
    return nil;
}

//  When a tweet is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Move to the DetaiViewController view using a 'push' animation
    DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailView animated:TRUE];
    
    //  Setting the information to be displayed
    NSDictionary *tweet = [twitterText objectAtIndex:indexPath.row];
    NSString *theText = [tweet valueForKey:@"text"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *date = [df dateFromString:[tweet valueForKey:@"created_at"]];
    [df setDateFormat:@"MMM dd yyyy @ hh:mm a"];
    NSString *dateStr = [df stringFromDate:date];
    NSString *theDate = dateStr;
    NSString *theUser = [[tweet valueForKey:@"user"]valueForKey:@"screen_name"];
    NSString *theImageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSString *friendsCount = [[tweet objectForKey:@"user"] objectForKey:@"friends_count"];
    NSString *userDesc = [[tweet objectForKey:@"user"] objectForKey:@"description"];
    NSString *followersCount = [[tweet objectForKey:@"user"] objectForKey:@"followers_count"];
    //  Sends the appropriate data/text to the DetailView for display
    [detailView passText:theText
                passDate:theDate
                passUser:theUser
                passImg:theImageUrl
                passFriends:friendsCount
                passDesc:userDesc
                passFollower:followersCount];
    
    NSLog(@"%@", theUser);
    NSLog(@"%@", theImageUrl);
    NSLog(@"%@", friendsCount);
    NSLog(@"%@", userDesc);
    NSLog(@"%@", followersCount);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
