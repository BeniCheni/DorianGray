//
//  ImagesTableViewController.m
//  DorianGray
//
//  Created by Beni Cheni on 4/19/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "DataSource.h"
#import "Media.h"
#import "User.h"
#import "Comment.h"
#import "MediaTableViewCell.h"

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        // Placeholder for initilization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
}

# pragma mark - KVO pattern

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        NSKeyValueChange kindOfChage = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        
        if (kindOfChage == NSKeyValueChangeSetting) {
            [self.tableView reloadData];
            
        } else if (kindOfChage == NSKeyValueChangeInsertion || kindOfChage == NSKeyValueChangeRemoval || kindOfChage == NSKeyValueChangeReplacement) {
            
            // Get a list of index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // Call 'beginUpdates' to tell the table view we're about to make changes
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChage == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChage == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChage == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done
            [self.tableView endUpdates];
        }
    }
}

- (void)dealloc {
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self items].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaTableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];

    cell.mediaItem = [self items][indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self items];
    Media *item = items[indexPath.row];
    
    return [MediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Media *item = [self items][indexPath.row];
        
        [[DataSource sharedInstance] deleteMediaItem:item];
    }
}

#pragma mark - Utility methods

- (NSArray *)items {
    return [DataSource sharedInstance].mediaItems;
}

- (void)refreshControlDidFire:(UIRefreshControl *)sender {
    [[DataSource sharedInstance] requestNewItemWithCompletionHandler:^(NSError *error) {
        [sender endRefreshing];
    }];
}

@end
