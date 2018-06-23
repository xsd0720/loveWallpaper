//
//  LoadingView.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/24.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView()
@property (nonatomic) NSTextField *textFiled;
@property (nonatomic) NSProgressIndicator *progress;
@end
@implementation LoadingView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if(self){
        self.backgroundColor = [[NSColor blackColor] colorWithAlphaComponent:0.6];
        
        self.textFiled = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 3, NSWidth(self.bounds), 40)];
        self.textFiled.stringValue = @"高清壁纸准备中...";
        self.textFiled.backgroundColor = [NSColor clearColor];
        self.textFiled.bordered = NO;
        self.textFiled.editable = NO;
        self.textFiled.selectable = NO;
        self.textFiled.font = [NSFont systemFontOfSize:22];
        self.textFiled.textColor = [NSColor whiteColor];
        self.textFiled.alignment = NSTextAlignmentCenter;
        [self addSubview:self.textFiled];
        
        self.progress = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(-5, -8, NSWidth(self.bounds)+10, 5)];
        [self.progress sizeToFit];
        self.progress.controlTint = NSClearControlTint;
        self.progress.controlSize = NSControlSizeRegular;
        self.progress.style = NSProgressIndicatorStyleBar;
        [self addSubview:self.progress];
        
        

    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.textFiled.stringValue = title;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self.progress startAnimation:nil];
}

@end
