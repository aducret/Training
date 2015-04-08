//
//  TableCellTableViewCell.m
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

@synthesize textLabel = _textLabel;
@synthesize emailLabel = _emailLabel;
@synthesize dateLabel = _dateLabel;
@synthesize likeImage = _likeImage;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
