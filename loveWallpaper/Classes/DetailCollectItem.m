//
//  DetailCollectItem.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/7/20.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "DetailCollectItem.h"

@interface DetailCollectItem ()
@property (nonatomic, strong) NSImageView *coverImageView;
@end

@implementation DetailCollectItem
- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.wantsLayer = true;
        self.view.layer.backgroundColor = [[NSColor blueColor] CGColor];
        //        [self.view updateTrackingAreas];
        
        self.coverImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
        self.coverImageView.wantsLayer = YES;
        self.coverImageView.contentMode = NSViewContentModeScaleAspectFill;
        self.coverImageView.layer.backgroundColor = [RGB(162, 39, 49) CGColor];
        [self.view addSubview:self.coverImageView];
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.coverImageView.image = nil;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
