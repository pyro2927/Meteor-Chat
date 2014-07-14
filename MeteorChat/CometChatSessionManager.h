//
//  CometChatSessionManager.h
//  MeteorChat
//
//  Created by Joseph Pintozzi on 7/14/14.
//  Copyright (c) 2014 pyro2927. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^CometChatCompletionBlock)(id object, NSError *error);

@interface CometChatSessionManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)signInWithUsername:(NSString *)username password:(NSString *)password completion:(CometChatCompletionBlock)completion;
- (void)setLoginWithToken:(NSString*)token;
- (NSURLSessionDataTask *)receiveWithTimestamp:(NSString*)timestamp completion:(CometChatCompletionBlock)completion;

@end