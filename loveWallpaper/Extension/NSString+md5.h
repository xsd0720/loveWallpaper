//
//  NSString+md5.h
//  loveWallpaper
//
//  Created by xiaowen on 2018/6/21.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)
- (NSString *)md5;
-(NSString*)encodeString;
+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2;
@end
