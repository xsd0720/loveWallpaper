//
//  HomeViewController.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/19.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "HomeViewController.h"
#import "BViewController.h"
#import "HttpTool.h"
#import "ImageCollectionViewItem.h"
#import "NSViewController+present.h"
#define AITETABLECELLIDENTIFIER  @"AITETABLECELLIDENTIFIER"


@interface HomeViewController ()<NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout, UITextFieldDelegate>
@property (nonatomic, strong) NSTableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSet;
@property (nonatomic, strong) NSScrollView *tableContainerView;
@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, strong) NSCollectionView *collectionView;
@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSImageView *bgImageView;

//@property (nonatomic, strong) NSTextField *searchTextFiled;
@property (nonatomic, strong) UITextField *searchTextFiled;

@end

@implementation HomeViewController
//- (void)loadView{
//    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
//    self.view = [[NSView alloc] initWithFrame:frame];
//    self.view.wantsLayer = YES;
//    self.view.layer.backgroundColor = [[NSColor getColor:@"#C20C0C"] CGColor];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.dataSet = [NSMutableArray array];
    self.view.backgroundColor = RGB(163, 39, 49);
    
    _bgImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
    _bgImageView.contentMode = NSViewContentModeScaleAspectFill;
    
//    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://p15.qhimg.com/bdr/__85/t013f358a6a343059ab.jpg"]];
    [self.view addSubview:_bgImageView];
    
    [HttpTool POST:@"http://api.breaker.club/wallpaper/bing" parameters:NULL success:^(NSDictionary *responsObject) {
        NSString *uri = responsObject[@"images"][0][@"url"];
        NSString *url = [NSString stringWithFormat:@"http://cn.bing.com%@", uri];
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(NSImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            _bgImageView.orginImage = image;
        }];

    } failure:^(NSError *error) {
        
    }];
    
    [_tableview setBackgroundColor:[NSColor clearColor]];
    [[_tableview enclosingScrollView] setDrawsBackground:NO];
    
    NSCollectionViewFlowLayout *layout = [[NSCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.itemSize = NSMakeSize(250, 150);
    layout.sectionInset = NSEdgeInsetsMake(200, 800, 200, 10);
    layout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
    
    _scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, self.view.bounds.size.width, NSHeight(self.view.bounds))];
    _collectionView = [[NSCollectionView alloc] initWithFrame:NSZeroRect];
    [_collectionView setCollectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setSelectable:true];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_collectionView registerClass:[ImageCollectionViewItem class] forItemWithIdentifier:@"nihao"];
    _scrollView.documentView = _collectionView;
    
    _collectionView.backgroundColors = @[[NSColor clearColor]];
    
    _scrollView.backgroundColor = [NSColor getColor:@"3dc2d5"];
    [_scrollView setHasHorizontalScroller:YES];
    [[_scrollView horizontalScroller] setAlphaValue:0];
    _scrollView.documentView = _collectionView;
    [self.view addSubview:_scrollView];
    [HttpTool POST:@"http://api.breaker.club/wallpaper/category" parameters:NULL success:^(NSDictionary *responsObject) {
        self.dataSet = responsObject[@"data"];
        [self.collectionView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
//
//    NSTextFieldCell *cell = [[NSTextFieldCell alloc] init];
//    cell.focusRingType = NSFocusRingTypeNone;
//    cell.placeholderString = @"搜索";
//    cell.stringValue = @"123";
//
    
    NSImageView *imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(15, 5, 20, 20)];
    [imageView setImage:[NSImage imageNamed:@"search"]];
    self.searchTextFiled = [[UITextField alloc] initWithFrame:NSMakeRect(NSWidth(self.view.bounds)-200, NSHeight(self.view.bounds)-100, 150, 30)];
    self.searchTextFiled.placeholder = @"关键词";
    self.searchTextFiled.delegate = self;
    self.searchTextFiled.font = [NSFont systemFontOfSize:14];
    self.searchTextFiled.leftView = imageView;
    [self.view addSubview:self.searchTextFiled];

}

//- (void)viewDidLayout{
//    self.bgImageView.frame = self.view.bounds;
////    [self.bgImageView update];
//}

- (void)textFieldEnterKey:(UITextField *)textFiled value:(NSString *)value{
    BViewController *b = [[BViewController alloc] init];
    b.q = value;
    b.cidtitle = value;
    [self presentViewController:b];
}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSet.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
//
    ImageCollectionViewItem *item = (ImageCollectionViewItem *)[collectionView makeItemWithIdentifier:@"nihao" forIndexPath:indexPath];
//    item.dic = @{@"image":@"http://p19.qhimg.com/bdm/1600_900_85/t01ae1f4579bf9e95fe.jpg"};
////    item.imageView.image = [[NSImage alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://p19.qhimg.com/bdm/1600_900_85/t01ae1f4579bf9e95fe.jpg"]];
    item.dic = self.dataSet[[indexPath indexAtPosition:1]];
    
    return item;
}


- (NSSet<NSIndexPath *> *)collectionView:(NSCollectionView *)collectionView shouldSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths NS_AVAILABLE_MAC(10_11){
    return indexPaths;
}
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths{
    [collectionView deselectItemsAtIndexPaths:indexPaths];
//    NSString *cid = self.dataSet[indexPaths[1]][@"id"]
    NSIndexPath *indexPath = [indexPaths anyObject];
    NSDictionary *dic = self.dataSet[[indexPath item]];
    NSString *cid = dic[@"cid"];
    

    BViewController *b = [[BViewController alloc] init];
    b.cid = cid;
    b.cidtitle = dic[@"name"];
    [self presentViewController:b];

}

@end
