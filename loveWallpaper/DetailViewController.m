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
@interface DetailViewController ()
@property (nonatomic, strong) NSImageView *bgImageView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    
    self.bgImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
    self.bgImageView.wantsLayer = true;
    self.bgImageView.contentMode = NSViewContentModeScaleAspectFill;
    self.bgImageView.layer.backgroundColor = [[NSColor purpleColor] CGColor];
    //        [self.coverImageView sd_setImageWithURL:self.dataSet[0][@"url"]];
    [self.bgImageView sd_setImageWithURL:self.dic[@"url"] completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        float ap = image.size.width/image.size.height;
        image.size = NSMakeSize(NSWidth(self.view.bounds), NSWidth(self.view.bounds)/ap);
        _bgImageView.image = image;
    }];
    [self.view addSubview:self.bgImageView];
    
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
- (void)back{
    [self.presentingViewController dismissViewController:self];
}

- (void)desktop{
    NSString *s = self.dic[@"url"];
    NSString *md5FileName = [NSString stringWithFormat:@"%@.%@", [s md5], [s pathExtension]];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:md5FileName];
    NSImage *im = self.bgImageView.image;
    NSData *d = [im TIFFRepresentation];
    
    [d writeToFile:filePath atomically:NO];
    
    [[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:filePath] forScreen:[NSScreen mainScreen] options:nil error:nil];
}

- (void)download{
    NSString *s = self.dic[@"url"];
    NSString *md5FileName = [NSString stringWithFormat:@"%@.%@", [s md5], [s pathExtension]];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:md5FileName];
    NSImage *im = self.bgImageView.image;
    NSData *d = [im TIFFRepresentation];
    [d writeToFile:filePath atomically:NO];
}


@end
