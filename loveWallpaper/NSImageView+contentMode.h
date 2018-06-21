//
//  NSImageView+contentMode.h
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, NSViewContentMode) {
    NSViewContentModeScaleToFill,
    NSViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
    NSViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
    NSViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
    NSViewContentModeCenter,              // contents remain same size. positioned adjusted.
    NSViewContentModeTop,
    NSViewContentModeBottom,
    NSViewContentModeLeft,
    NSViewContentModeRight,
    NSViewContentModeTopLeft,
    NSViewContentModeTopRight,
    NSViewContentModeBottomLeft,
    NSViewContentModeBottomRight,
} NS_ENUM_AVAILABLE_MAC(10_10);

@interface NSImageView (contentMode)

@property (nonatomic, assign) NSViewContentMode contentMode;
@end
