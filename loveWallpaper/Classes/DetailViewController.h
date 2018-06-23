//
//  DetailViewController.h
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DetailViewController : NSViewController
@property (nonatomic) NSDictionary *dic;
@property (nonatomic) NSMutableArray *list;
@property (nonatomic) NSInteger current;
@end
