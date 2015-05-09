//
//  Media.h
//  DorianGray
//
//  Created by Beni Cheni on 4/19/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MediaDownloadState) {
    MediaDownloadStateNeedsImage = 0,
    MediaDownloadStateDownloadInProgress = 1,
    MediaDownloadStateNonRecoverableError = 2,
    MediaDownloadStateHasImage = 3
};

@class User;

@interface Media : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) MediaDownloadState downloadState;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;

- (instancetype)initWithDictionary:(NSDictionary *)mediaDictionary;

@end
