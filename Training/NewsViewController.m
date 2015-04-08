//
//  NewsViewmController.m
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//
#import <Parse/Parse.h>

#import "NewsViewController.h"
#import "Comment.h"
#import "TableCell.h"
#import "NSDate+TimeAgo.h"

@interface NewsViewController ()

@property (nonatomic) NSMutableArray * items;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [[NSMutableArray alloc]init];
    [self loadInitData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell * cell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Comment * comment = [self.items objectAtIndex:indexPath.row];
    [self initCell:cell withComment:comment];
    
    return cell;
}

#pragma mark - Private methods

- (void) initCell: (TableCell *) cell withComment: (Comment *) comment {
    cell.textLabel.text = comment.text;
    cell.likeImage.image = [UIImage imageNamed:@"i-like-inactive"];
    cell.emailLabel.text = comment.email;
    cell.dateLabel.text = [comment.creationDate timeAgo];
}

- (void)loadInitData {
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %ld scores.", objects.count);
            [self.items addObjectsFromArray:objects];
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
