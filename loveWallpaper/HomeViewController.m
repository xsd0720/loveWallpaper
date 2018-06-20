//
//  HomeViewController.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/19.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "HomeViewController.h"
#import "NSColor+extension.h"
#import "HttpTool.h"
#import "ImageCollectionViewItem.h"
#import "UIImageView+WebCache.h"
#define AITETABLECELLIDENTIFIER  @"AITETABLECELLIDENTIFIER"
#define RGBA(r,g,b,a) [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


@interface HomeViewController ()<NSTableViewDelegate, NSTableViewDataSource, NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSTableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSet;
@property (nonatomic, strong) NSScrollView *tableContainerView;
@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, strong) NSCollectionView *collectionView;
@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSImageView *bgImageView;
@end

@implementation HomeViewController
- (void)loadView{
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    self.view = [[NSView alloc] initWithFrame:frame];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [[NSColor getColor:@"#C20C0C"] CGColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.dataSet = [NSMutableArray array];
    
    [self loadView];
    
    _bgImageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://p15.qhimg.com/bdr/__85/t013f358a6a343059ab.jpg"]];
    [self.view addSubview:_bgImageView];
    
    
    _tableContainerView = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];

    _tableview = [[NSTableView alloc] initWithFrame:CGRectMake(0, 0,
                                                               _tableContainerView.frame.size.width,
                                                               _tableContainerView.frame.size.height)];

    NSTableColumn * column = [[NSTableColumn alloc]initWithIdentifier:@"test"];
    column.title = @"分类";
    self.tableview = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, 300, 100)];
    [self.tableview addTableColumn:column];
    [self.tableview setDraggingDestinationFeedbackStyle:NSTableViewDraggingDestinationFeedbackStyleGap];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
    
    [_tableContainerView setDocumentView:_tableview];
//    [self.view addSubview:_tableContainerView];
    [_tableview setBackgroundColor:[NSColor clearColor]];
    [[_tableview enclosingScrollView] setDrawsBackground:NO];
    
    NSCollectionViewFlowLayout *layout = [[NSCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.itemSize = NSMakeSize(250, 150);
    layout.sectionInset = NSEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
    
    _scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, self.view.bounds.size.width, 200)];
    _scrollView.scrollerKnobStyle = NSScrollerKnobStyleDefault;
    _collectionView = [[NSCollectionView alloc] initWithFrame:NSZeroRect];
    [_collectionView setCollectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSNib *theNib = [[NSNib alloc] initWithNibNamed:@"ImageCollectionViewItem" bundle:nil];
//    [_collectionView registerNib:theNib forItemWithIdentifier:AITETABLECELLIDENTIFIER];
    [_collectionView registerClass:[ImageCollectionViewItem class] forItemWithIdentifier:@"nihao"];
    _scrollView.documentView = _collectionView;
//    _collectionView.wantsLayer = YES;
    
//    [_collectionView.layer setBackgroundColor:[[NSColor clearColor] CGColor]];
//    [[_collectionView enclosingScrollView] setDrawsBackground:YES];
    
    _collectionView.backgroundColors = @[[NSColor clearColor]];
    
    
//    NSView *v = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 200, 200)];
//    v.wantsLayer = YES;
//    v.layer.backgroundColor = [[NSColor redColor] CGColor];
    
    _scrollView.backgroundColor = [NSColor getColor:@"3dc2d5"];
    _scrollView.documentView = _collectionView;
    [self.view addSubview:_scrollView];
    [HttpTool POST:@"http://cdn.apc.360.cn/index.php?c=WallPaper&a=getAllCategoriesV2&from=360chrome" parameters:NULL success:^(NSDictionary *responsObject) {

        self.dataSet = responsObject[@"data"];
//        NSLog(@"%@", self.dataSet);
//        [self.tableview reloadData];
        [self.collectionView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataSet.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    return  nil;
}
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return  100;
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTextField *vi = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
    vi.backgroundColor = RGB(163, 39, 49);
    [vi setStringValue:self.dataSet[row][@"name"]];
    vi.editable = false;
//    vi.drawsBackground = NO;
    vi.bezeled = NO;
    vi.selectable = NO;
    return vi;
}
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    NSString *xid = self.dataSet[row][@"id"];
    NSString *url = [NSString stringWithFormat:@"http://wallpaper.apc.360.cn/index.php?c=WallPaper&a=getAppsByCategory&cid=%@&start=1&count=20&from=360chrome", xid];
    NSLog(@"%@", url);
    [HttpTool POST:url parameters:NULL success:^(NSDictionary *responsObject) {
        
        self.arr = responsObject[@"data"];
        NSLog(@"%@", self.arr);
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    return  true;
//    return true;
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
    
    
//    item.view.frame = NSMakeRect(item.view.frame.origin.x, item.view.frame.origin.y, 250, 150);
    return item;
}
//- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
//    return  nil;
//}
//- (NSCollectionViewItem *)newItemForRepresentedObject:(id)object{
//    return nil;
//}
@end
