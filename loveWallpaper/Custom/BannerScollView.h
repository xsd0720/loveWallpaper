//
//  BannerScollView.h
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/23.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BannerScollView : NSView
@property (nonatomic) NSInteger current;
@property (nonatomic, strong) NSMutableArray *dataSet;
@end
