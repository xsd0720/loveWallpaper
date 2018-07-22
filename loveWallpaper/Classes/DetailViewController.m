//
//  DetailViewController.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "DetailViewController.h"
#import "SDWebImageDownloader.h"
#import "BannerScollView.h"
#import "LoadingView.h"
#import "XXScrollView.h"
#import "DetailCollectItem.h"
@interface DetailViewController ()<NSCollectionViewDelegate, NSCollectionViewDataSource>
@property (nonatomic, strong) NSImageView *bgImageView;
@property (nonatomic, strong) BannerScollView *mainScrollView;
@property (nonatomic, strong) NSImage *curImage;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) NSCollectionView *collectionView;
@property (nonatomic, strong) XXScrollView *scrollView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:NSMakeRect(0, 0, NSWidth(self.view.bounds)/2, 50)];
    [self.loadingView center];
   
    self.mainScrollView = [[BannerScollView alloc] initWithFrame:self.view.bounds];
    self.mainScrollView.dataSet = self.list;
    self.mainScrollView.current = self.current;
    [self.view addSubview:self.mainScrollView];
//    NSCollectionViewFlowLayout *layout = [[NSCollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 0;
//    layout.itemSize = NSMakeSize(self.view.bounds.size.width, self.view.bounds.size.height);
//    //        layout.sectionInset = NSEdgeInsetsMake(100, 100, 100, 100);
//    layout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
//
//
//    _collectionView = [[NSCollectionView alloc] initWithFrame:NSZeroRect];
//    [_collectionView setCollectionViewLayout:layout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    [_collectionView setSelectable:true];
//    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [_collectionView registerClass:[DetailCollectItem class] forItemWithIdentifier:@"wohao"];
//    _collectionView.backgroundColors = @[[NSColor clearColor]];
    
//    _scrollView = [[XXScrollView alloc] initWithFrame:NSMakeRect(0, 0, NSWidth(self.view.bounds), NSHeight(self.view.bounds))];
//    [_scrollView setHorizontalScrollElasticity:NSScrollElasticityNone];
//    [_scrollView setHasHorizontalScroller:YES];
//    [[_scrollView horizontalScroller] setAlphaValue:0];
//    _scrollView.documentView = _collectionView;
//    [self.view addSubview:_scrollView];
    
    NSButton *back = [[NSButton alloc] initWithFrame:NSMakeRect(0, NSHeight(self.view.bounds)-80, 62, 49)];
    [back setTarget:self];
    [back setImage:[NSImage imageNamed:@"BackButton_62x49_"]];
    [back setAction:@selector(back)];
    [back setBordered:NO];
    [self.view addSubview:back];

    NSButton *setdesktop = [[NSButton alloc] initWithFrame:NSMakeRect(NSWidth(self.view.bounds)-80, 50, 36, 36)];
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
}
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 1;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCollectItem *item = (DetailCollectItem *)[collectionView makeItemWithIdentifier:@"wohao" forIndexPath:indexPath];
    item.dic = self.list[indexPath.item];
    return item;
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
}

- (void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)desktop{
    if (self.loadingView.superview) {
        return;
    }
    [self.loadingView center];
    [self.view addSubview:self.loadingView];
    NSString *s = self.list[self.mainScrollView.current][@"url"];
    NSString *md5FileName = [NSString stringWithFormat:@"%@.%@", [s md5], [s pathExtension]];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:md5FileName];
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:s] options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(NSImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        NSData *d = [image TIFFRepresentation];
        [d writeToFile:filePath atomically:NO];
        
        [[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:filePath] forScreen:[NSScreen mainScreen] options:nil error:nil];
        [self.loadingView removeFromSuperview];
    }];

}

- (void)download{
    
    if (self.loadingView.superview) {
        return;
    }
    [self.loadingView center];
    [self.view addSubview:self.loadingView];
    NSString *s = self.list[self.mainScrollView.current][@"url"];
    NSString *md5FileName = [NSString stringWithFormat:@"%@.%@", [s md5], [s pathExtension]];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:md5FileName];

    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:s] options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(NSImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        NSData *d = [image TIFFRepresentation];
        [d writeToFile:filePath atomically:NO];
        [self.loadingView removeFromSuperview];
    }];
    
    
}

- (void)viewDidDisappear{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
