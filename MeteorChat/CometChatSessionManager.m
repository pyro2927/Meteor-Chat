//
//  CometChatSessionManager.m
//  MeteorChat
//
//  Created by Joseph Pintozzi on 7/14/14.
//  Copyright (c) 2014 pyro2927. All rights reserved.
//

#import "CometChatSessionManager.h"

@interface CometChatSessionManager(){
    NSString *authenticationToken;
    NSString *blh;
}

@end

@implementation CometChatSessionManager

- (id)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url])
    {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (NSURLSessionDataTask *)signInWithUsername:(NSString *)username password:(NSString *)password completion:(CometChatCompletionBlock)completion
{
    NSParameterAssert(username);
    NSParameterAssert(password);
    
    return [self GET:@"cometchat/extensions/mobileapp/login.php" parameters:@{@"password": password, @"username": username, @"callbackfn": @"mobileapp"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *token = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [self setLoginWithToken:token];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error logging in: %@", error.localizedDescription);
    }];
    
}

- (void)setLoginWithToken:(NSString*)token{
    authenticationToken = token;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    [self receiveWithTimestamp:nil completion:^(id object, NSError *error) {
        
    }];
}

- (NSURLSessionDataTask *)receiveWithTimestamp:(NSString*)timestamp completion:(CometChatCompletionBlock)completion{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"buddylist": @"1", @"basedata": authenticationToken, @"status": @"available", @"callbackfn": @"mobileapp"}];
    //send a timestamp if we have one
    if (timestamp == nil) {
        [params setValue:@"1" forKey:@"initialize"];
    } else {
        [params setValue:timestamp forKey:@"timestamp"];
    }
    //cryptic blh
    if (blh != nil) {
        [params setValue:blh forKey:@"blh"];
    }
    return [self GET:@"cometchat/cometchat_receive.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        blh = responseObject[@"blh"];
        completion(responseObject, false);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error receiving in: %@", error.localizedDescription);
    }];
}

@end
