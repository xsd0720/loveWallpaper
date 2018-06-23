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

//- (void)viewDidAppear{

//    NSWindow *win = [[NSApplication sharedApplication] keyWindow];

//    NSLayoutConstraint *leftLaytout = [NSLayoutConstraint constraintWithItem:win.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
//
//    NSLayoutConstraint *rightLaytout = [NSLayoutConstraint constraintWithItem:win.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:20];
//
//    NSLayoutConstraint *topLaytout = [NSLayoutConstraint constraintWithItem:win.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:20];
//
//    NSLayoutConstraint *bottomLaytout = [NSLayoutConstraint constraintWithItem:win.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
    
    
//    NSLayoutConstraint *leftLaytout = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:win.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
//
//    NSLayoutConstraint *rightLaytout = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:win.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
//
//    NSLayoutConstraint *topLaytout = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:win.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:30];
//
//    NSLayoutConstraint *bottomLaytout = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:win.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
//    topLaytout.priority = NSLayoutPriorityDefaultLow;
//    [self.view addConstraints:@[leftLaytout, rightLaytout, topLaytout, bottomLaytout]];
//    [win.contentView addConstraint:leftLaytout];
//    [win.contentView addConstraint:rightLaytout];
//    [win.contentView addConstraint:topLaytout];
//    [win.contentView addConstraint:bottomLaytout];
    
//}

@end
