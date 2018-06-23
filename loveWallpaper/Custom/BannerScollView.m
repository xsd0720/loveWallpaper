//
//  BannerScollView.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/23.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "BannerScollView.h"
#import "NSView+Extension.h"
#import "XXScrollView.h"
#import "UIImageView+WebCache.h"
#import "NSImageView+contentMode.h"
@interface BannerScollView()<XXScrollViewViewDelegate>
@property (nonatomic, strong) NSImageView *leftImageView;
@property (nonatomic, strong) NSImageView *middleImageView;
@property (nonatomic, strong) NSImageView *rightImageView;
@property (nonatomic, strong) XXScrollView *mainScrollView;
@property (nonatomic, assign) float lastOffset;

@end

@implementation BannerScollView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        float winW = NSWidth(self.bounds);
        float winH = NSHeight(self.bounds);
        
        self.leftImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, winW, winH)];
        self.middleImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(winW, 0, winW, winH)];
        self.rightImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(winW*2, 0, winW, winH)];
        
        self.leftImageView.backgroundColor = RGB(162, 39, 49);
        self.middleImageView.backgroundColor = RGB(162, 39, 49);
        self.rightImageView.backgroundColor = RGB(162, 39, 49);
        
        self.leftImageView.contentMode = NSViewContentModeScaleAspectFill;
        self.middleImageView.contentMode = NSViewContentModeScaleAspectFill;
        self.rightImageView.contentMode = NSViewContentModeScaleAspectFill;
        
        self.mainScrollView = [[XXScrollView alloc] initWithFrame:self.bounds];
        self.mainScrollView.backgroundColor = [NSColor orangeColor];
        self.mainScrollView.contentSize = NSMakeSize(winW*3, 0);
        self.mainScrollView.delegate = self;
        [self addSubview:self.mainScrollView];
        
        [self.mainScrollView addSubview:self.leftImageView];
        [self.mainScrollView addSubview:self.middleImageView];
        [self.mainScrollView addSubview:self.rightImageView];
        
    }
    return self;
}

- (void)refreshData{
    if (_current<0) {
        return;
    }
    
    if (_current >=1 && _current<(self.dataSet.count-1)) {
        NSInteger leftindex = (_current+self.dataSet.count-1) % self.dataSet.count;
        NSInteger rightindex = (_current+1) % self.dataSet.count;
        
        NSString *leftUrl = self.dataSet[leftindex][@"url"];
        NSString *middleUrl = self.dataSet[_current][@"url"];
        NSString *rightUrl = self.dataSet[rightindex][@"url"];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftUrl]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middleUrl]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightUrl]];
        
        [self.mainScrollView setBoundsOrigin:NSMakePoint(NSWidth(self.mainScrollView.bounds), 0)];
    }else if(_current==0){
        
        NSString *leftUrl = self.dataSet[0][@"url"];
        NSString *middleUrl = self.dataSet[1][@"url"];
        NSString *rightUrl = self.dataSet[2][@"url"];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftUrl]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middleUrl]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightUrl]];
        
        [self.mainScrollView setBoundsOrigin:NSMakePoint(0, 0)];
    }
    else if (_current==(self.dataSet.count-1)){
        
        NSString *leftUrl = self.dataSet[self.dataSet.count-3][@"url"];
        NSString *middleUrl = self.dataSet[self.dataSet.count-2][@"url"];
        NSString *rightUrl = self.dataSet[self.dataSet.count-1][@"url"];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftUrl]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middleUrl]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightUrl]];
        
        [self.mainScrollView setBoundsOrigin:NSMakePoint(NSWidth(self.mainScrollView.bounds)*2, 0)];
    }


}

- (void)setCurrent:(NSInteger)current{
    _current = current;
    [self refreshData];
}
- (void)scrollViewDidEndDragging:(XXScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
        self.current++;
        if (self.current > self.dataSet.count-1) {
            self.current = self.dataSet.count-1;
        }
    }else{
        self.current--;
        if (self.current < 0) {
            self.current = 0;
        }
    }
    NSLog(@"%li", (long)self.current);
    [self refreshData];
   
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
