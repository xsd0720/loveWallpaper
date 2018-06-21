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
@end
