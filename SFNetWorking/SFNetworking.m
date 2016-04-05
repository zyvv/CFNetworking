//
//  SFNetworking.m
//  SFNetworkingExample
//
//  Created by 张洋威 on 16/3/16.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "SFNetworking.h"
#import <UIKit/UIKit.h>

static NSString const *_key = @""; // 后台给定的key

@implementation SFNetworking


+ (void)old_getWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure {
    
    //创建request请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperation *operation = nil;
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    NSMutableDictionary *parametersWithKey = nil;
    if (parameters) {
        parametersWithKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parametersWithKey = [NSMutableDictionary dictionary];
    }
    [parametersWithKey setObject:_key forKey:@"key"];
    operation = [manager GET:url
                  parameters:parametersWithKey
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         
                         completion(responseObject);
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                         });
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                         failure(error);
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                         });
                     }];
    
    //设置返回数据的解析方式
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    
    [operation start];

    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
}

+ (void)old_postWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure {

    //创建request请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperation *operation = nil;
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    NSMutableDictionary *parametersWithKey = nil;
    if (parameters) {
        parametersWithKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parametersWithKey = [NSMutableDictionary dictionary];
    }
    [parametersWithKey setObject:_key forKey:@"key"];
    
    BOOL isFile = NO;
    //判断请求参数是否有文件数据
    for (NSString *key in parameters) {
        id value = parameters[key];
        if ([value isKindOfClass:[NSData class]]) {
            isFile = YES;
            break;
        }
    }
    
    if (!isFile) {
        //参数中没有文件类型
        operation = [manager POST:url
                       parameters:parametersWithKey
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              completion(responseObject);
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                              });
                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              failure(error);
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                              });
                          }];
    } else
    {
        operation = [manager POST:url
                       parameters:parametersWithKey
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (NSString *key in parameters) {
                id value = parameters[key];
                if ([value isKindOfClass:[NSData class]]) {
                    [formData appendPartWithFileData:value name:key fileName:key mimeType:@"image/jpeg"];
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completion(responseObject);
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }];
    }

    //设置返回数据的解析方式
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];


    [operation start];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
}

+ (void)setKey:(NSString *)key {
    _key = key;
}
@end
