//
//  JCNetworking.m
//  TenProject
//
//  Created by Ten on 2018/4/30.
//  Copyright © 2018年 Ten. All rights reserved.
//

#import "JCNetworking.h"
#import "AFNetworking.h"

@implementation JCNetworking

+(NSURLSessionDataTask *)GET:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setDictionary:parameters];
    [dict setObject:@"ios" forKey:@"source"];
    AFHTTPSessionManager *manager = [JCNetworking standardUserDefaults];
    NSURLSessionDataTask *task = [manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"code"] isKindOfClass:[NSNull class]]) {
            NSNumber *number = responseObject[@"code"];
            
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return task;
}

+(NSURLSessionDataTask *)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setDictionary:parameters];
    [dict setObject:@"ios" forKey:@"source"];
    AFHTTPSessionManager *manager = [JCNetworking standardUserDefaults];
    NSURLSessionDataTask *task = [manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"code"] isKindOfClass:[NSNull class]]) {
            NSNumber *number = responseObject[@"code"];
            
        }
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return task;
}

//+(NSURLSessionDataTask *)uploadMostImageWithURLString:(NSString *)URLString parameters:(id)parameters uploadDatas:(NSArray *)uploadDatas uploadName:(NSString *)uploadName success:(void (^)(id))success failure:(void (^)(NSError *))failure{
//
//}

+(void)settingToken:(NSString *)token{
    AFHTTPSessionManager *manager = [JCNetworking standardUserDefaults];
    [manager.requestSerializer setValue: token forHTTPHeaderField:@"token"];
}

+(AFHTTPSessionManager *)standardUserDefaults{
    // 初始化管理者
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"", nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20;
        
        //内容类型
        
        //get请求
    });
    return manager;
}

@end
