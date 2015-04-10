//
//  TableCellTableViewCell.h
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (nonatomic) NSNumber * index;

@property (weak, nonatomic) IBOutlet UILabel * emailLabel;
@property (weak, nonatomic) IBOutlet UILabel * textLabel;
@property (weak, nonatomic) IBOutlet UILabel * dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

