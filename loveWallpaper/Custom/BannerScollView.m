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
#import "DetailImageItem.h"
@interface BannerScollView()<XXScrollViewViewDelegate>
@property (nonatomic, strong) NSImageView *leftImageView;
@property (nonatomic, strong) NSImageView *middleImageView;
@property (nonatomic, strong) NSImageView *rightImageView;
@property (nonatomic, strong) XXScrollView *mainScrollView;
@property (nonatomic, assign) float lastOffset;
@property (nonatomic, strong) NSMutableArray *itemArrays;

@end

@implementation BannerScollView

- (instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        float winW = NSWidth(self.bounds);
        float winH = NSHeight(self.bounds);
        
        self.itemArrays = [[NSMutableArray alloc] init];
        
//        self.leftImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, winW, winH)];
//        self.middleImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(winW, 0, winW, winH)];
//        self.rightImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(winW*2, 0, winW, winH)];
//
//        self.leftImageView.backgroundColor = RGB(162, 39, 49);
//        self.middleImageView.backgroundColor = RGB(162, 39, 49);
//        self.rightImageView.backgroundColor = RGB(162, 39, 49);
//
//        self.leftImageView.contentMode = NSViewContentModeScaleAspectFill;
//        self.middleImageView.contentMode = NSViewContentModeScaleAspectFill;
//        self.rightImageView.contentMode = NSViewContentModeScaleAspectFill;
        
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

- (void)setDataSet:(NSMutableArray *)dataSet{
    _dataSet = dataSet;
    float winW = NSWidth(self.bounds);
    float winH = NSHeight(self.bounds);
    for (int i=0; i<MIN(3, dataSet.count); i++) {
        DetailImageItem *item = [[DetailImageItem alloc] initWithFrame:NSMakeRect(winW*i, 0, winW, winH)];
        [self.itemArrays addObject:item];
        [self.mainScrollView addSubview:item];
    }
    [self.mainScrollView setContentSize:NSMakeSize(winW*MIN(dataSet.count, 3), winH)];
}
- (void)refreshData{
    if (_current<0) {
        return;
    }
    if (_current == 0) {
        for (int i=0;i<self.itemArrays.count;i++) {
            DetailImageItem *item = (DetailImageItem *)self.itemArrays[i];
            NSInteger index = _current+i;
            [item setDic:self.dataSet[index]];
        }
        [self.mainScrollView setBoundsOrigin:NSMakePoint(0, 0)];
    }
    else if (_current == (self.dataSet.count-1)){
        for (int i=0;i<self.itemArrays.count;i++) {
            DetailImageItem *item = (DetailImageItem *)self.itemArrays[i];
            NSInteger index = _current-(self.itemArrays.count-i-1);
            [item setDic:self.dataSet[index]];
        }
        if (_current==1) {
            [self.mainScrollView setBoundsOrigin:NSMakePoint(NSWidth(self.mainScrollView.bounds), 0)];
        }else{
            [self.mainScrollView setBoundsOrigin:NSMakePoint(NSWidth(self.mainScrollView.bounds)*2, 0)];
        }
    }else{
        for (int i=0;i<self.itemArrays.count;i++) {
            DetailImageItem *item = (DetailImageItem *)self.itemArrays[i];
            NSInteger index = _current+i-1;
            [item setDic:self.dataSet[index]];
        }
        [self.mainScrollView setBoundsOrigin:NSMakePoint(NSWidth(self.mainScrollView.bounds), 0)];
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
//    [self refreshData];
   
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
