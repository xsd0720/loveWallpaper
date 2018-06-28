//
//  NSLabel.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/28.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "NSLabel.h"

@implementation NSLabel

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        self.selectable = NO;
        self.editable = NO;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
