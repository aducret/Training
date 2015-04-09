//
//  NewsViewmController.m
//  Training
//
//  Created by Argentino Ducret on 4/8/15.
//  Copyright (c) 2015 Wolox. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIView+Toast.h>

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
    [self initRefreshControl];
    [self initItemsArray];
    [self setEmptyListImage];
    [self loadData];
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
    if([self.items count] > 0) {
        Comment * comment = [self.items objectAtIndex:indexPath.row];
        [self initCell:cell withComment:comment];
    }
    
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate
{
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        [self launchReload];
    }
}

#pragma mark - Private methods

- (void)refresh:(id)sender {
    [self.items removeAllObjects];
    [self launchReload];
    [(UIRefreshControl *)sender endRefreshing];
}

- (void) initCell: (TableCell *) cell withComment: (Comment *) comment {
    cell.textLabel.text = comment.text;
    cell.likeImage.image = [UIImage imageNamed:@"i-like-inactive"];
    cell.emailLabel.text = comment.email;
    cell.dateLabel.text = [comment.creationDate timeAgo];
}

- (void)loadData {
    PFQuery * query = [PFQuery queryWithClassName:@"Comment"];
    query.limit = 7;
    query.skip = [self.items count];
    [query orderByDescending:@"creationDate"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count > 0) {
            NSLog(@"Successfully retrieved %ld scores.", objects.count);
            [self.items addObjectsFromArray:objects];
            self.tableView.backgroundView = nil;
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        } else {
            [self.view makeToast:NSLocalizedString(@"serverError", nil)];
            [self setServerErrorImage];
        }
    }];
}

- (void)setEmptyListImage {
    UIImage * image = [UIImage imageNamed:@"first"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.tableView.backgroundView = imageView;
}

- (void)setServerErrorImage {
    UIImage * image = [UIImage imageNamed:@"i-error"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.tableView.backgroundView = imageView;

}

- (void)launchReload {
    [self loadData];
}

- (void)initRefreshControl {
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refresh];
}

- (void)initItemsArray {
    self.items = [[NSMutableArray alloc]init];
}

@end
