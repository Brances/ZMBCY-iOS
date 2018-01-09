//
//  ZMUserInfo.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/6.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMUserInfo.h"

#define userSessionToken @"userSessionToken"

static ZMUserInfo *_userInfo;
@implementation ZMUserInfo

/** 用户信息类的单例 */
+ (instancetype)shareUserInfo{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[ZMUserInfo alloc] init];
    });
    return _userInfo;
}

- (BOOL)isLogin{
    return self.userId.length && self.sessionToken.length;
}

- (NSString *)sexName{
    NSString *string = nil;
    if (self.sex == 0) {
        string = @"谜之生物";
    }else if (self.sex == 1){
        string = @"女";
    }else{
        string = @"男";
    }
    return string;
}

- (void)saveUserInfoToSandbox{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.sessionToken forKey:userSessionToken];
    [defaults synchronize];
}

- (void)loadUserInfoFromSandbox{
    self.sessionToken = [[NSUserDefaults standardUserDefaults] objectForKey:userSessionToken];
}

- (void)loadUserInfo:(AVObject *)user{
    if (user) {
        self.userId =       user.objectId;
        self.sessionToken = ((AVUser *)user).sessionToken;
        self.userName =     ((AVUser *)user).username;
        self.email =        ((AVUser *)user).email;
        self.emailVerfied = [user[@"emailVerified"] boolValue];
        self.thumb =        user[@"thumb"];
        self.sex =          [user[@"sex"] integerValue];
        self.signature =    user[@"signature"];
    }
}

- (void)updateUserInfo:(AVObject *)user{
    if ([user isKindOfClass:[AVObject class]]) {
        self.userId =   user[@"objectId"];
        self.userName = user[@"username"];
        self.email =    user[@"email"];
        self.emailVerfied = [user[@"emailVerified"] boolValue];
        self.thumb =    user[@"thumb"];
        self.sex =      [user[@"sex"] integerValue];
        self.signature =    user[@"signature"];
    }
}

- (void)loginOut{
    self.userId = nil;
    self.sessionToken = nil;
    self.userName = nil;
    self.email = nil;
    self.emailVerfied = nil;
    self.thumb = nil;
    self.signature = nil;
    [self saveUserInfoToSandbox];
}

@end
