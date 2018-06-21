//
//  ClipView.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/20.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "ClipView.h"

@implementation ClipView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(0, 0)];
    [path lineToPoint:NSMakePoint(dirtyRect.size.width-12, 0)];
    [path lineToPoint:NSMakePoint(dirtyRect.size.width, dirtyRect.size.height)];
    [path lineToPoint:NSMakePoint(0, dirtyRect.size.height)];
    [path closePath];
    [[NSColor blackColor] set];
    [path fill];
    self.alphaValue = 0.6;
}

- (void)resetCursorRects{
    [super resetCursorRects];
    [self addCursorRect:self.bounds cursor:[NSCursor pointingHandCursor]];
}
@end
