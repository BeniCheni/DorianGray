//
//  MediaTableViewCell.h
//  DorianGray
//
//  Created by Beni Cheni on 4/20/15.
//  Copyright (c) 2015 Princess of Darkness Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;
+ (CGFloat)heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

@end
