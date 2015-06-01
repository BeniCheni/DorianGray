//
//  DataSource.h
//  DorianGray
//
//  Created by Beni Cheni on 4/19/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

typedef void(^NewItemCompletionBlock)(NSError *error);

@interface DataSource : NSObject

+ (NSString *)instagramClientID;
+ (instancetype)sharedInstance;
@property (nonatomic, strong, readonly) NSString *accessToken;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

- (void)deleteMediaItem:(Media *)item;
- (void)requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void)requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void)downloadImageForMediaItem:(Media *)mediaItem;
- (void)toggleLikeOnMediaItem:(Media *)mediaItem withCompletionHandler:(void (^)(void))completionHandler;
- (void)commentOnMediaItem:(Media *)mediaItem withCommentText:(NSString *)commentText;

@end
