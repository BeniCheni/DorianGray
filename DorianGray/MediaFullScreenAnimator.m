//
//  MediaFullScreenAnimator.m
//  DorianGray
//
//  Created by Beni Cheni on 5/5/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import "MediaFullScreenAnimator.h"
#import "MediaFullScreenViewController.h"

@implementation MediaFullScreenAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.presenting) {
        MediaFullScreenViewController *fullScreenVC = (MediaFullScreenViewController *)toVC;
        
        fromVC.view.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:toVC.view];
        
        CGRect startFrame = [transitionContext.containerView convertRect:self.cellImageView.bounds fromView:self.cellImageView];
        CGRect endFrame = fromVC.view.frame;
        
        toVC.view.frame = startFrame;
        fullScreenVC.imageView.frame = toVC.view.bounds;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            
            fullScreenVC.view.frame = endFrame;
            [fullScreenVC centerScrollView];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        MediaFullScreenViewController *fullScreenVC = (MediaFullScreenViewController *)fromVC;
        
        CGRect endFrame = [transitionContext.containerView convertRect:self.cellImageView.bounds fromView:self.cellImageView];
        CGRect imageStartFrame = [fullScreenVC.view convertRect:fullScreenVC.imageView.frame fromView:fullScreenVC.scrollView];
        CGRect imageEndFrame = [transitionContext.containerView convertRect:endFrame toView:fullScreenVC.view];
        
        imageEndFrame.origin.y = 0;
        
        [fullScreenVC.view addSubview:fullScreenVC.imageView];
        fullScreenVC.imageView.frame = imageStartFrame;
        fullScreenVC.imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        
        toVC.view.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fullScreenVC.view.frame = endFrame;
            fullScreenVC.imageView.frame = imageEndFrame;
            
            toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
