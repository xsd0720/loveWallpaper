//
//  DetailImageItem.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/7/22.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "DetailImageItem.h"
@interface DetailImageItem()
@property (nonatomic, strong) NSImageView *coverImageView;
@property (nonatomic, strong) NSView *loadingView;
@property (nonatomic, strong) NSLabel *label;
@end
@implementation DetailImageItem
- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        
        self.coverImageView = [[NSImageView alloc] initWithFrame:self.bounds];
        self.coverImageView.wantsLayer = YES;
        self.coverImageView.contentMode = NSViewContentModeScaleAspectFill;
        self.coverImageView.layer.backgroundColor = [RGB(162, 39, 49) CGColor];
        [self addSubview:self.coverImageView];
        
        self.loadingView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
        self.loadingView.backgroundColor = [[NSColor blackColor] colorWithAlphaComponent:0.6];
        [self.loadingView center];
        [self addSubview:self.loadingView];
        
        
        self.label = [[NSLabel alloc] initWithFrame:self.loadingView.bounds];
        self.label.stringValue = @"Loading";
        self.label.alignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [NSColor clearColor];
        [self.loadingView addSubview:self.label];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.coverImageView.image = nil;
    self.loadingView.hidden = NO;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]]completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.loadingView.hidden = YES;
    }];
}
@end
