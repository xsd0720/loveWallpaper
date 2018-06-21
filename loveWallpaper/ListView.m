//
//  ListView.m
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "ListView.h"
#import "HttpTool.h"
@interface ListView()
@property(nonatomic) NSMutableArray *dataSet;
@property (nonatomic) NSScrollView *scroll;
@property(nonatomic) NSCollectionView *collectionView;
@end

@implementation ListView

- (void)setCid:(NSString *)cid{
    _cid = cid;
    NSString *url = [NSString stringWithFormat:@"http://api.breaker.club/wallpaper/list?cid=%@&start=1&count=10", cid];
    
    [HttpTool GET:url parameters:NULL success:^(NSDictionary *responsObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
