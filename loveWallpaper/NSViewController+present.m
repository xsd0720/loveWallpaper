//
//  NSViewController+present.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "NSViewController+present.h"
#import "CustomAnimator.h"
#import "VCView.h"
@implementation NSViewController (present)

- (void)loadView{
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    VCView *v = [[VCView alloc] initWithFrame:frame];
    self.view = v;
}
- (void)presentViewController:(NSViewController *)viewController{
    CustomAnimator *an = [[CustomAnimator alloc] init];
    [self presentViewController:viewController animator:an];
}
- (void)dismiss{
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewController:self];
    }
    else{
        [[[NSApplication sharedApplication] mainWindow] close];
    }
}
- (void)mouseDown:(NSEvent *)event{
    [super mouseDown:event];
}


@end
