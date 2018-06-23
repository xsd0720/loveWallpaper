//
//  CustomAnimator.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "CustomAnimator.h"

@implementation CustomAnimator
- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    
    NSViewController* bottomVC = fromViewController;
    NSViewController* topVC = viewController;
    
    //    // make sure the view has a CA layer for smooth animation
    topVC.view.wantsLayer = YES;
    //
    //    // set redraw policy
    //    topVC.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    //
    //    // start out invisible
    topVC.view.alphaValue = 0;
    
    // add view of presented viewcontroller
    float w = [NSApplication sharedApplication].keyWindow.frame.size.width;
    float h = [NSApplication sharedApplication].keyWindow.frame.size.height;
    
    topVC.view.frame = NSMakeRect(0, 0, w, h);
    [[NSApplication sharedApplication].keyWindow.contentView addSubview:topVC.view];
//    [bottomVC addChildViewController:topVC];
    
    //    // adjust size and colour
    //    CGRect frame = NSRectToCGRect(bottomVC.view.frame);
    //    frame = CGRectInset(frame, 40, 40);
    //    [topVC.view setFrame:NSRectFromCGRect(frame)];
    bottomVC.view.hidden = YES;
    
    // Do some CoreAnimation stuff to present view
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 1;
        topVC.view.animator.alphaValue = 1;
    } completionHandler:nil];
    
}

- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    
    NSViewController* bottomVC = fromViewController;
//    bottomVC.view.hidden = NO;
    NSViewController* topVC = viewController;
//    [topVC.view removeFromSuperview];
    
//    [topVC removeFromParentViewController];
    //
    //    // make sure the view has a CA layer for smooth animation
    //    topVC.view.wantsLayer = YES;
    //
    //    // set redraw policy
    //    topVC.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    //
    //    // Do some CoreAnimation stuff to present view
    bottomVC.view.hidden = NO;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 1;
        topVC.view.animator.alphaValue = 0;
    } completionHandler:^{
        [topVC.view removeFromSuperview];
    }];
    
}
@end
