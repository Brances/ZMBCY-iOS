//
//  ZMNetworkHelper.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMNetworkHelper : NSObject

+ (AFHTTPSessionManager *)sharedInstance;

/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);
/** 请求失败的Block */
typedef void(^HttpRequestFailure)(NSError *error);

#pragma mark - GET请求
+ (void) requestGETWithRequestURL:(NSString *) requestURLString
                       parameters:(id)parameters
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;

#pragma mark - POST请求
+ (void) requestPOSTWithRequestURL:(NSString *) requestURLString
                        parameters:(id)parameters
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailure)failure;

@end
