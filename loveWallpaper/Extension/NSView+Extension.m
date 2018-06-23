//
//  NSView+Extension.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "NSView+Extension.h"

@implementation NSView (Extension)
@dynamic backgroundColor;
- (void)setBackgroundColor:(NSColor *)backgroundColor{
    self.wantsLayer = true;
    self.layer.backgroundColor = [backgroundColor CGColor];
}

- (void)mouseMoved:(NSEvent *)event{
    
}

- (void)center{
    NSWindow *win = [[NSApplication sharedApplication] keyWindow];
    
    float x = (NSWidth(win.contentView.bounds)-NSWidth(self.bounds))/2;
    float y = (NSHeight(win.contentView.bounds)-NSHeight(self.bounds))/2;
    
    [self setFrameOrigin:NSMakePoint(x, y)];
}
@end
