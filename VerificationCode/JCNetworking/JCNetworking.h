//
//  JCNetworking.h
//  TenProject
//
//  Created by Ten on 2018/4/30.
//  Copyright © 2018年 Ten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCNetworking : NSObject
/**
 GET数据请求
 
 @param urlString  URL
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (NSURLSessionDataTask *)GET:(NSString *)urlString parameters:(id)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

/**
 POST数据请求
 
 @param urlString  URL
 @param parameters 参数
 @param success    成功回调
 @param failure    失败回调
 */
+ (NSURLSessionDataTask *)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;


// 上传多张图片  uploadDatas 图片的data集合
// uploadName 文件名称 最好以xxx1  xxx2 表示 image1 image2
+ (NSURLSessionDataTask *)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *))failure;

+ (void)settingToken:(NSString *)token;

@end
