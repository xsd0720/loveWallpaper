//
//  DetailViewController.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "NSString+md5.h"
#import "NSImageView+contentMode.h"
#import "NSView+Extension.h"
#import <QuartzCore/CAAnimation.h>
@interface DetailViewController ()
@property (nonatomic, strong) NSImageView *bgImageView;
@property (nonatomic, strong) NSScrollView *mainScrollView;
@property (nonatomic, strong) NSImage *curImage;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do view setup here.
////    NSGestureRecognizer
//    _mainScrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
//    _mainScrollView.backgroundColor = [NSColor magentaColor];
////    _mainScrollView.contentView.automaticallyAdjustsContentInsets = NO;
////    _mainScrollView.contentView = [[NSClipView alloc] initWithFrame:self.view.bounds];
////    _mainScrollView.accessibilitySortDirection = NSAccessibilitySortDirectionDescending;
//    NSRect r = NSMakeRect(0, 0, NSWidth(self.view.bounds)*3, NSHeight(self.view.bounds));
//    _mainScrollView.verticalLineScroll = 100;
////    _mainScrollView.contentView.intrinsicContentSize= NSMakeSize(10, 10);
//
//
//    NSView *contentView = [[NSView alloc] initWithFrame:r];
//    contentView.backgroundColor = [NSColor orangeColor];
//
//    NSView *a = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, NSWidth(self.view.bounds), NSHeight(self.view.bounds))];
//    NSView *b = [[NSView alloc] initWithFrame:NSMakeRect(NSWidth(self.view.bounds), 0, NSWidth(self.view.bounds), NSHeight(self.view.bounds))];
//    NSView *c = [[NSView alloc] initWithFrame:NSMakeRect(NSWidth(self.view.bounds)*2, 0, NSWidth(self.view.bounds), NSHeight(self.view.bounds))];
//    a.backgroundColor = [NSColor redColor];
//    b.backgroundColor = [NSColor purpleColor];
//    c.backgroundColor = [NSColor orangeColor];
//
//
//    [contentView addSubview:a];
//    [contentView addSubview:b];
//    [contentView addSubview:c];
//
//    _mainScrollView.documentView = contentView;
//
////    [_mainScrollView setScrollerStyle:NSScrollerStyleOverlay];
//    [self.view addSubview:_mainScrollView];
////    [_mainScrollView setVerticalScroller:<#(NSScroller * _Nullable)#>]
//    _mainScrollView.usesPredominantAxisScrolling = YES;
//    _mainScrollView.horizontalScrollElasticity = NSScrollElasticityAutomatic;
//    const CGFloat interval = NSWidth(self.view.bounds);
//    [[NSNotificationCenter defaultCenter]
//     addObserverForName:NSViewBoundsDidChangeNotification
//     object:_mainScrollView.contentView
//     queue:nil
//     usingBlock:^(NSNotification* notification) {
////         [_mainScrollView i]
//         NSClipView *changedContentView=[notification object];
//         NSLog(@"%f", _mainScrollView.contentView.bounds.origin.x);
////         _mainScrollView.
////         CGFloat offset = _mainScrollView.contentView.bounds.origin.x;
////         offset = round(offset / interval) * interval;
////         [_mainScrollView.contentView.animator setBoundsOrigin:NSMakePoint(offset, 0)];
//     }];
//    _mainScrollView.gestureRecognizers
//    [_mainScrollView setHorizontalScrollElasticity:NSScrollElasticityAutomatic];

//    [[self.mainScrollView contentView] setPostsBoundsChangedNotifications:YES];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(abc:) name:NSViewBoundsDidChangeNotification object:[self.mainScrollView contentView]];
//    _mainScrollView.scrollsDynamically = YES;

//    [self.mainScrollView.contentView scrollPoint:NSMakePoint(500, 0)];
//
    self.bgImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
    self.bgImageView.wantsLayer = true;
    self.bgImageView.contentMode = NSViewContentModeScaleAspectFill;
    self.bgImageView.layer.backgroundColor = [[NSColor purpleColor] CGColor];
    //        [self.coverImageView sd_setImageWithURL:self.dataSet[0][@"url"]];
    [self.bgImageView sd_setImageWithURL:self.dic[@"url"] completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        _curImage = image;
        float ap = image.size.width/image.size.height;
        image.size = NSMakeSize(NSWidth(self.view.bounds), NSWidth(self.view.bounds)/ap);
        _bgImageView.image = image;
    }];
    [self.view addSubview:self.bgImageView];
//
    NSButton *back = [[NSButton alloc] initWithFrame:NSMakeRect(0, NSHeight(self.view.bounds)-100, 62, 49)];
    [back setTarget:self];
    [back setImage:[NSImage imageNamed:@"BackButton_62x49_"]];
    [back setAction:@selector(back)];
    [back setBordered:NO];
    [self.view addSubview:back];

    NSButton *setdesktop = [[NSButton alloc] initWithFrame:NSMakeRect(NSWidth(self.view.bounds)-100, 50, 36, 36)];
    [setdesktop setTarget:self];
    [setdesktop setImage:[NSImage imageNamed:@"BarButton_Desktop_32x32_"]];
    [setdesktop setAction:@selector(desktop)];
    [setdesktop setBordered:NO];
    [self.view addSubview:setdesktop];

    NSButton *download = [[NSButton alloc] initWithFrame:NSMakeRect(NSWidth(self.view.bounds)-200, 50, 36, 36)];
    [download setTarget:self];
    [download setImage:[NSImage imageNamed:@"BarButton_Download_32x32_"]];
    [download setAction:@selector(download)];
    [download setBordered:NO];
    [self.view addSubview:download];
    
}

- (void)abc:(NSNotification *)noti{
    NSLog(@"1");
}

- (void)back{
    [self.presentingViewController dismissViewController:self];
//    NSLog(@"%@", NSStringFromRect(_mainScrollView.contentView.bounds));
    
//    CABasicAnimation *animation = [CABasicAnimation
//
//                                   animationWithKeyPath: @"transform" ];
//
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//
//    //围绕Z轴旋转，垂直与屏幕
//
//    animation.toValue = [NSValue valueWithCATransform3D:
//
//                         CATransform3DMakeRotation(M_PI,0.0, 0.0,1.0) ];
//
//    animation.duration =1;
//
//    animation.cumulative =YES;
//
//    animation.repeatCount =100000;
//
//    self.mainScrollView.layer.anchorPoint =CGPointMake(0.5,0.5);
//
//    [self.mainScrollView.layer addAnimation:animation forKey:nil];
    
    
    
    
}
//#pragma CATransition动画实现
//- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
//{
//        //创建CATransition对象
//        CATransition *animation = [CATransition animation];
//
//        //设置运动时间
//        animation.duration = DURATION;
//
//        //设置运动type
//        animation.type = type;
//        if (subtype != nil) {
//
//                //设置子类
//                animation.subtype = subtype;
//            }
//UIViewAnimationTransitionFlipFromRight
//        //设置运动速度
//        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//
//        [view.layer addAnimation:animation forKey:@"animation"];
//}
- (void)desktop{
    NSString *s = self.dic[@"url"];
    NSString *md5FileName = [NSString stringWithFormat:@"%@.%@", [s md5], [s pathExtension]];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:md5FileName];

    NSData *d = [self.curImage TIFFRepresentation];
    [d writeToFile:filePath atomically:NO];
    
    [[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:filePath] forScreen:[NSScreen mainScreen] options:nil error:nil];
}

- (void)download{
    NSString *s = self.dic[@"url"];
    NSString *md5FileName = [NSString stringWithFormat:@"%@.%@", [s md5], [s pathExtension]];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:md5FileName];
    NSData *d = [self.curImage TIFFRepresentation];
    [d writeToFile:filePath atomically:NO];
    
    
}

- (void)viewDidDisappear{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
