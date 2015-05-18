//
//  LikeButton.h
//  DorianGray
//
//  Created by Beni Cheni on 5/11/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LikeState) {
    LikeStateNotLiked = 0,
    LikeStateLiking   = 1,
    LikeStateLiked    = 2,
    LikeStateUnliking = 3
};

@interface LikeButton : UIButton

/*
 * LikeButtonedNotLiked - empty heart
 * LikeButtonLiked - heart
 * LikeButtonLiking & LikeButtonUnliking - activity indicator and disable button tap until the button is set to LikeButtonNotLiked or LikeButtonLiked
 */
@property (nonatomic, assign) LikeState likeButtonState;

@end
