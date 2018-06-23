//
//  HttpTool.h
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/19.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^HttpToolSuccessBlock)(NSDictionary *responsObject);
typedef void(^HttpToolFailBlock)(NSError *error);

@interface HttpTool : NSObject

/**
 *  单例
 *
 *  @return 单例对象
 */
+ (HttpTool *)sharedInstance;


/**
 *  GET 请求
 *
 *  @param URLString  请求地址URL
 *  @param parameters 附带参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(HttpToolSuccessBlock)success
    failure:(HttpToolFailBlock)failure;


/**
 *  POST 请求
 *
 *  @param URLString  请求地址URL
 *  @param parameters 附带参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(HttpToolSuccessBlock)success
     failure:(HttpToolFailBlock)failure;

@end
