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
#import "MediaFullScreenViewController.h"
#import "MediaFullScreenAnimator.h"

@interface ImagesTableViewController () <MediaTableViewCellDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIImageView *lastTappedImageView;

@end

@implementation ImagesTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        // Placeholder for custom initilization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    // pull-to-refresh
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

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self items].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.mediaItem = [self items][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        [self loadVisibleImages];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
    
    if (item.image) {
        return 350;
    } else {
        return 150;
    }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self infiniteScrollIfNecessary];
}

#pragma mark - MediaTableViewCellDelegate methods

- (void)cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView {
    self.lastTappedImageView = imageView;
    
    MediaFullScreenViewController *fullScreenVC = [[MediaFullScreenViewController alloc] initWithMedia:cell.mediaItem];
    
    fullScreenVC.transitioningDelegate = self;
    fullScreenVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}

- (void)cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (cell.mediaItem.caption.length > 0) {
        [itemsToShare addObject:cell.mediaItem.caption];
    }
    
    if (cell.mediaItem.image) {
        [itemsToShare addObject:cell.mediaItem.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

- (void)cellDidPressLikeButton:(MediaTableViewCell *)cell {
    Media *item = cell.mediaItem;
    
    [[DataSource sharedInstance] toggleLikeOnMediaItem:item withCompletionHandler:^{
        if (cell.mediaItem == item) {
            cell.mediaItem = item;
        }
    }];
    
    cell.mediaItem = item;
}

#pragma mark - UIViewControllerTransistioningDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    MediaFullScreenAnimator *animator = [MediaFullScreenAnimator new];
    animator.presenting = YES;
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MediaFullScreenAnimator *animator = [MediaFullScreenAnimator new];
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}

#pragma mark - Utility methods

- (NSArray *)items {
    return [DataSource sharedInstance].mediaItems;
}

- (void)refreshControlDidFire:(UIRefreshControl *)sender {
    [[DataSource sharedInstance] requestNewItemsWithCompletionHandler:^(NSError *error) {
        [self loadVisibleImages]; // Load images after pull-to-refresh for new data.
        [sender endRefreshing];
    }];
}

- (void)infiniteScrollIfNecessary {
    NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexPath && bottomIndexPath.row == [self items].count - 1) {
        [[DataSource sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}

- (void)loadVisibleImages {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for (NSIndexPath *indexPath in [self.tableView indexPathsForVisibleRows]) {
            Media *mediaItem = [self items][indexPath.row];
            if (mediaItem.downloadState == MediaDownloadStateNeedsImage) {
                [[DataSource sharedInstance] downloadImageForMediaItem:mediaItem];
            }
        }
    });
}

@end
