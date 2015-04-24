//
//  DataSource.h
//  DorianGray
//
//  Created by Beni Cheni on 4/19/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface DataSource : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;
- (void)deleteMediaItem:(Media *)item;

@end
