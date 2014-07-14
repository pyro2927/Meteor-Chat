//
//  CometChatViewController.m
//  MeteorChat
//
//  Created by Joseph Pintozzi on 7/14/14.
//  Copyright (c) 2014 pyro2927. All rights reserved.
//

#import "CometChatViewController.h"
#import "CometChatMessage.h"

@interface CometChatViewController ()

@end

@implementation CometChatViewController

- (NSString *)sender{
    return @"Joe";
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView
       messageDataForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [[CometChatMessage alloc] init];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

@end
