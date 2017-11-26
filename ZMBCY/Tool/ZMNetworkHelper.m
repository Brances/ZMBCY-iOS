//
//  ZMNetworkHelper.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMNetworkHelper.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation ZMNetworkHelper

static AFHTTPSessionManager *manager ;

+ (AFHTTPSessionManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 打开状态栏的等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 20;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript",@"text/html" ,nil];
    });
    return manager;
}

+ (void)requestGETWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    [[ZMNetworkHelper sharedInstance] GET:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

+ (void)requestPOSTWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    [[ZMNetworkHelper sharedInstance] POST:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

@end

#ifdef DEBUG
@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif

