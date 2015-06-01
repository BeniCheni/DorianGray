//
//  MediaTableViewCell.h
//  DorianGray
//
//  Created by Beni Cheni on 4/20/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell, ComposeCommentView;

@protocol MediaTableViewCellDelegate <NSObject>

- (void)cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void)cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;
- (void)cellDidPressLikeButton:(MediaTableViewCell *)cell;
- (void)cellWillStartComposingComent:(MediaTableViewCell *)cell;
- (void)cell:(MediaTableViewCell *)cell didComposeComment:(NSString *)comment;

@end

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;
@property (nonatomic, weak) id <MediaTableViewCellDelegate> delegate;
@property (nonatomic, strong, readonly) ComposeCommentView *commentView;

+ (CGFloat)heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;
- (void)stopComposingComment;

@end
