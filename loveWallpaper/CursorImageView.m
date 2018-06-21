//
//  CursorImageView.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "CursorImageView.h"

@implementation CursorImageView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (void)resetCursorRects{
    [self addCursorRect:self.bounds cursor:[NSCursor pointingHandCursor]];
}
@end
