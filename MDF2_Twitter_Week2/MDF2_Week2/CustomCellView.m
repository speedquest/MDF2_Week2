//
//  CustomCellView.m
//  MDF2_Week2
//
//  Created by Nicholas Weil on 10/30/12.
//  Copyright (c) 2012 Nicholas Weil. All rights reserved.
//

#import "CustomCellView.h"

@implementation CustomCellView
@synthesize tweetLabel, timeStampLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
