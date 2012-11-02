//
//  ViewController.h
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    IBOutlet UITableView *twitterTableView;
    NSArray *twitterText;
    NSString *timeOfTweet;
    UIView *loading;
    __weak IBOutlet UIView *loadingTweetsScreen;
    UIActivityIndicatorView *waitingIcon;

}
@property (strong, nonatomic) IBOutlet UITableView *twitterTableView;
@property (strong, atomic) NSArray *twitterText;
@property (strong, atomic) NSString *twitterTime;

@end
