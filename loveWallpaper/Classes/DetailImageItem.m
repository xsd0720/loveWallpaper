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
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.coverImageView.image = nil;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]]];
}
@end
