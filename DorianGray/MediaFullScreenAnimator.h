//
//  MediaFullScreenAnimator.h
//  DorianGray
//
//  Created by Beni Cheni on 5/5/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaFullScreenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, weak) UIImageView *cellImageView;

@end
