//
//  HttpTool.m
//  loveWallpaper
//
//  Created by FaiWong on 2018/6/19.
//  Copyright © 2018年 lovebizi. All rights reserved.
//

#import "HttpTool.h"


@implementation HttpTool
/**
 *  单例
 *
 *  @return 单例
 */
+ (HttpTool *)sharedInstance
{
    static HttpTool *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


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
    failure:(HttpToolFailBlock)failure{
    
    
    //发起请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    [manager GET:URLString
      parameters:parameters
         success:^(NSURLSessionDataTask *task,
                   id responseObject) {
             
             /**
              *  成功回调
              *  @param responseObject 请求的数据结果
              */
             //判断是否有数据
             if(responseObject){

                 success(responseObject);
             }
             else
             {
                 //无数据返回，返回错误信息
                 NSError *error = [NSError errorWithDomain:@"no data result" code:0 userInfo:nil];
                 failure(error);
             }
             
             
         }
         failure:^(NSURLSessionDataTask *task,
                   NSError *error) {
             
             
             /**
              *  失败回调
              *  @param error 错误代码
              */
             if(error){

                 failure(error);
             }
         }];
    
}


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
     failure:(HttpToolFailBlock)failure{
    
    
    //发起请求
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
    
//    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    [manager POST:URLString
       parameters:parameters
          success:^(NSURLSessionDataTask *task,
                    id responseObject) {
              
              
              /**
               *  成功回调
               *  @param responseObject 请求的数据结果
               */
              //判断是否有数据
              if(responseObject){
                  success(responseObject);
              }
              else
              {
                  //无数据返回，返回错误信息
                  NSError *error = [NSError errorWithDomain:@"no data result" code:0 userInfo:nil];
                  failure(error);
              }
              
              
          }
          failure:^(NSURLSessionDataTask *task,
                    NSError *error) {
              
              /**
               *  失败回调
               *  @param error 错误代码
               */
              if(error){
                  
                  failure(error);
                  
              }
          }];
    
    
}

@end
