//
//  CustomCellView.h
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellView : UITableViewCell
{
    IBOutlet UILabel *tweetLabel;
    IBOutlet UILabel *timeStampLabel;
}

@property (strong, nonatomic)IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic)IBOutlet UILabel *timeStampLabel;

@end
