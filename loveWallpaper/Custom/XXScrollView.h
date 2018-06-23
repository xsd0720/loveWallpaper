//
//  XXScrollView.h
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/22.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XXScrollView;

@protocol XXScrollViewViewDelegate <NSObject>
- (void)scrollViewDidEndDragging:(XXScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end

@interface XXScrollView : NSView
@property (nonatomic) NSSize contentSize;
@property (nonatomic) BOOL pagingEnable;
@property (nonatomic, assign) id<XXScrollViewViewDelegate> delegate;
@end
