//
//  CursorImageView.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "CursorImageView.h"

@implementation CursorImageView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
//        NSTrackingArea *trackArea = [[NSTrackingArea alloc] initWithRect:self.frame options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow) owner:self userInfo:nil];
//        [self addTrackingArea:trackArea];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}

//- (void)mouseEntered:(NSEvent *)event{
//    [[NSCursor pointingHandCursor] set];
//}
//
//- (void)mouseExited:(NSEvent *)event{
//    [[NSCursor arrowCursor] set];
//}
@end
