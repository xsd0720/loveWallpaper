//
//  BViewController.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//
//{
//    "img_1366_768":"http://p15.qhimg.com/bdm/1366_768_85/t013f358a6a343059ab.jpg",
//    "imgcut":"0",
//    "update_time":"2018-06-15 16:25:56",
//    "utag":"性感美女 风韵 长腿",
//    "img_1280_1024":"http://p15.qhimg.com/bdm/1280_1024_85/t013f358a6a343059ab.jpg",
//    "img_1600_900":"http://p15.qhimg.com/bdm/1600_900_85/t013f358a6a343059ab.jpg",
//    "url_mid":"http://p15.qhimg.com/t013f358a6a343059ab.jpg",
//    "class_id":"6",
//    "tempdata":"",
//    "rdata":[
//
//    ],
//    "download_times":"0",
//    "img_1024_768":"http://p15.qhimg.com/bdm/1024_768_85/t013f358a6a343059ab.jpg",
//    "img_1280_800":"http://p15.qhimg.com/bdm/1280_800_85/t013f358a6a343059ab.jpg",
//    "url":"http://p15.qhimg.com/bdr/__85/t013f358a6a343059ab.jpg",
//    "tag":"_全部_ _category_性感美女_ _category_风韵_ _category_长腿_ _category_美女模特_",
//    "create_time":"2018-06-15 16:25:56",
//    "url_thumb":"http://p15.qhimg.com/t013f358a6a343059ab.jpg",
//    "resolution":"1920x1080",
//    "id":"320411",
//    "url_mobile":"http://p15.qhimg.com/t013f358a6a343059ab.jpg",
//    "img_1440_900":"http://p15.qhimg.com/bdm/1440_900_85/t013f358a6a343059ab.jpg"
//},
#import "BViewController.h"
#import "ImageCollectionViewItem.h"
#import "NSColor+extension.h"
#import "HttpTool.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "NSViewController+present.h"
#import "NSImageView+contentMode.h"

#define GROUPSIZE  9.0

@interface BViewController ()<NSCollectionViewDelegate, NSCollectionViewDataSource,NSCollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSCollectionView *collectionView;
@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSImageView *coverImageView;
@property (nonatomic, strong) NSImageView *backImageView;
@property (nonatomic, strong) NSMutableArray *dataSet;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation BViewController

- (NSCollectionView *)collectionView{
    if (!_collectionView) {
        NSCollectionViewFlowLayout *layout = [[NSCollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 20;
        layout.itemSize = NSMakeSize(250, 150);
//        layout.sectionInset = NSEdgeInsetsMake(100, 100, 100, 100);
        layout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;

        _collectionView = [[NSCollectionView alloc] initWithFrame:NSZeroRect];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setSelectable:true];
        [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_collectionView registerClass:[ImageCollectionViewItem class] forItemWithIdentifier:@"nihao"];
        _collectionView.backgroundColors = @[[NSColor clearColor]];
        
        
        _scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, NSWidth(self.view.bounds), NSHeight(self.view.bounds))];
        [_scrollView setHorizontalScrollElasticity:NSScrollElasticityNone];
        [_scrollView setHasHorizontalScroller:YES];
        [[_scrollView horizontalScroller] setAlphaValue:0];
        _scrollView.documentView = _collectionView;
        [self.view addSubview:_scrollView];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    
    self.dataSet = [[NSMutableArray alloc] init];
    self.coverImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
    self.coverImageView.wantsLayer = true;
    self.coverImageView.contentMode = NSViewContentModeScaleAspectFill;
    [self.view addSubview:self.coverImageView];
    
    [self.collectionView reloadData];
    
    [self loadData];

    NSButton *back = [[NSButton alloc] initWithFrame:NSMakeRect(0, NSHeight(self.view.bounds)-80, 62, 49)];
    [back setTarget:self];
    [back setImage:[NSImage imageNamed:@"BackButton_62x49_"]];
    [back setAction:@selector(back)];
    [back setBordered:NO];
    [self.view addSubview:back];
    
    
    NSTextField *te = [[NSTextField alloc] initWithFrame:NSMakeRect(80, NSHeight(self.view.bounds)-85, 300, 49)];
    te.stringValue = self.cidtitle;
    te.backgroundColor = [NSColor clearColor];
    te.bordered = NO;
    te.editable = NO;
    te.selectable = NO;
    te.textColor = [NSColor whiteColor];
    te.font = [NSFont systemFontOfSize:25];
    [self.view addSubview:te];
    
//    _backImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 62,49)];
//    [_backImageView setImage:[NSImage imageNamed:@"BackButton_62x49_"]];
//    [_backImageView setEnabled:NO];
//    [back addSubview:_backImageView];
}
- (void)loadData{
    static int start = 1;
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    NSString *url = @"";
    if (self.q) {
        url = [NSString stringWithFormat:@"http://api.breaker.club/wallpaper/list?a=search&start=%i&count=27&kw=%@", start, [self.q encodeString]];
    }else{
        url = [NSString stringWithFormat:@"http://api.breaker.club/wallpaper/list?cid=%@&start=%i&count=27", self.cid, start];
    }
    [HttpTool GET:url parameters:NULL success:^(NSDictionary *responsObject) {
        if ([responsObject[@"errno"]  isEqual: @"0"]) {
            NSArray *tmpd = responsObject[@"data"];
            [self.dataSet addObjectsFromArray:tmpd];
            if (self.dataSet.count>0) {
                [self.coverImageView sd_setImageWithURL:self.dataSet[0][@"url"] completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    float ap = image.size.width/image.size.height;
                    image.size = NSMakeSize(NSWidth(self.view.bounds), NSWidth(self.view.bounds)/ap);
                    _coverImageView.image = image;
                }];
                [self.collectionView reloadData];
            }
 
            self.isLoading = NO;
            start+=27;
        }else{
            
        }

    } failure:^(NSError *error) {
        
    }];
}

- (NSEdgeInsets)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return NSEdgeInsetsMake(100, 300, 100, 50);
    }
    return NSEdgeInsetsMake(100, 100, 100, 50);
}
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.dataSet.count>=GROUPSIZE?GROUPSIZE:self.dataSet.count;
    return self.dataSet.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
//    return ceil(self.dataSet.count/GROUPSIZE);
    return 1;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCollectionViewItem *item = (ImageCollectionViewItem *)[collectionView makeItemWithIdentifier:@"nihao" forIndexPath:indexPath];
    NSInteger index = indexPath.item;
    NSInteger section = indexPath.section*GROUPSIZE;
    item.dic = self.dataSet[index+section];
    return item;
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    [collectionView deselectItemsAtIndexPaths:indexPaths];
    NSIndexPath *indexPath = [indexPaths anyObject];
    NSInteger index = indexPath.item;
    NSInteger section = indexPath.section*GROUPSIZE;
    DetailViewController *detailVc = [[DetailViewController alloc] init];
    detailVc.dic = self.dataSet[index];
    detailVc.list = self.dataSet;
    detailVc.current = index+section;
    [self presentViewController:detailVc];
}

- (void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == self.dataSet.count-2) {
        [self loadData];
    }
//
//    if (indexPath.section == (self.dataSet.count/GROUPSIZE)-2) {
//        [self loadData];
//    }
}

- (void)back{
    [self.presentingViewController dismissViewController:self];
}

@end
