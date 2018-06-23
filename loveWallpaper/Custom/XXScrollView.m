//
//  XXScrollView.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/22.
//  Copyright © 2018年 lovebizi. All rights reserved.
//
//https://juejin.im/entry/579489c0a633bd006a462d97
#import "XXScrollView.h"

@interface XXScrollView()<NSAnimationDelegate>
@property (nonatomic, strong) NSView *contentView;
@property (nonatomic, strong) NSPanGestureRecognizer *panGesture;
@property (nonatomic, assign) BOOL isJump;

//@property (nonatomic, assign) float maxOriginX;
@end
@implementation XXScrollView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        self.contentView = [[NSView alloc] initWithFrame:frameRect];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setContentSize:(NSSize)contentSize{
    _contentSize = contentSize;
    self.contentView.frame = NSMakeRect(0, 0, contentSize.width, contentSize.height);
    if (contentSize.width>self.bounds.size.width) {
        self.panGesture = [[NSPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:self.panGesture];
    }
}

- (void)scrollWheel:(NSEvent *)event{
    
    BOOL isFast = fabs(event.scrollingDeltaX)>20;
    if (event.phase == NSEventPhaseBegan) {
        self.isJump = NO;
    }
    if ((event.phase == NSEventPhaseChanged) && !isFast && _isJump==NO) {
        // 修改bounds
        CGRect bounds = self.bounds;
        bounds.origin.x -= event.scrollingDeltaX;
        
        if (bounds.origin.x<=0) {
            bounds.origin.x = 0;
        }
        if (bounds.origin.x>= (self.contentSize.width-NSWidth(self.bounds))) {
            bounds.origin.x = self.contentSize.width-NSWidth(self.bounds);
        }
        self.bounds = bounds;
    }

    
//    id touches = [event touchesMatchingPhase:event.phase inView:self];
    if (!self.isJump) {
        if ((event.phase == NSEventPhaseEnded) || isFast) {
            self.isJump = YES;
            float interval = NSWidth(self.bounds);
            CGFloat offset = self.bounds.origin.x;
            offset = round(offset / interval) * interval;
            if (isFast) {
                if (event.scrollingDeltaX<0) {
                    offset+=interval;
                }
                else{
                    offset-=interval;
                }
            }
            if (offset<0) {
                offset = 0;
            }
            int x = self.contentSize.width/self.bounds.size.width;
            x = x - 1;
            if (offset>interval*x) {
                offset = interval*x;
            }

            BOOL isChange = (offset != self.bounds.origin.x);
            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
                [self.animator setBoundsOrigin:NSMakePoint(offset, 0)];
            } completionHandler:^{
                if (isChange) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
                        [self.delegate scrollViewDidEndDragging:self willDecelerate:event.scrollingDeltaX<0];
                    }
                }

            }];
            

        }
    }

}

- (void)animationDidStop:(NSAnimation *)animation{
    
}
- (void)panAction:(NSPanGestureRecognizer *)pan {
    
    // 获取手指的偏移量
    CGPoint transP = [pan translationInView:pan.view];
    
    // 修改bounds
    CGRect bounds = self.bounds;
    bounds.origin.x -= transP.x;
    if (bounds.origin.x<=0) {
        bounds.origin.x = 0;
    }
    if (bounds.origin.x>= (self.contentSize.width-NSWidth(self.bounds))) {
        bounds.origin.x = self.contentSize.width-NSWidth(self.bounds);
    }
    self.bounds = bounds;
    // 复位
    [pan setTranslation:CGPointZero inView:pan.view];
    
}

@end
