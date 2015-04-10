//
//  TableCellTableViewCell.m
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import "TableCell.h"

@interface TableCell()

@property (nonatomic) NSNotificationCenter * notificationCenter;

@end

@implementation TableCell

@synthesize textLabel = _textLabel;
@synthesize emailLabel = _emailLabel;
@synthesize dateLabel = _dateLabel;
@synthesize likeButton = _likeButton;

- (void)awakeFromNib {
    self.notificationCenter = [NSNotificationCenter defaultCenter];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (IBAction)imageTaped:(id)sender {
    [self sendLikeNewNotification];
    if([self.likeButton.imageView.image isEqual:[UIImage imageNamed:@"i-like-active"]]) {
        [self.likeButton setImage:[UIImage imageNamed:@"i-like-inactive"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"i-like-active"] forState:UIControlStateNormal];
    }
}

#pragma mark - Private Methods

- (void)sendLikeNewNotification {
    [self.notificationCenter postNotificationName:@"likeNewNotification" object:self
                                         userInfo:@{@"index" : self.index}];
}
@end
