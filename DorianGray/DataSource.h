//
//  DataSource.h
//  DorianGray
//
//  Created by Beni Cheni on 4/19/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

typedef void(^NewItemCompletionBlock)(NSError *error);

@interface DataSource : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;


- (void)deleteMediaItem:(Media *)item;
- (void)requestNewItemWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

@end
