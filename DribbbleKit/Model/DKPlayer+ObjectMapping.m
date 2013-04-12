//
//  DKPlayer+ObjectMapping.m
//  DribbbleKitDemo
//
//  Created by 0day on 13-4-8.
//  Copyright (c) 2013年 All4Love. All rights reserved.
//

#import "DKPlayer+ObjectMapping.h"

static RKRequestDescriptor *RequestDescriptor = nil;
static RKResponseDescriptor *ResponseDescriptor = nil;
static RKEntityMapping *EntityResponseMapping = nil;

@implementation DKPlayer (ObjectMapping)

+ (NSDictionary *)objectMappingDictionary {
    NSDictionary *playerMappingDictionary = @{
                                              @"id": @"playerID",
                                              @"name": @"name",
                                              @"username": @"userName",
                                              @"url": @"url",
                                              @"avatar_url": @"avatarURL",
                                              @"location": @"location",
                                              @"twitter_screen_name": @"twitterScreenName",
                                              @"drafted_by_player_id": @"draftedByPlayerID",
                                              @"shots_count": @"shotsCount",
                                              @"draftees_count": @"drafteesCount",
                                              @"followers_count": @"followersCount",
                                              @"following_count": @"followingCount",
                                              @"comments_count": @"commentsCount",
                                              @"comments_received_count": @"commentsReceivedCount",
                                              @"likes_count": @"likesCount",
                                              @"likes_received_count": @"likesReceivedCount",
                                              @"rebounds_count": @"reboundsCount",
                                              @"rebounds_received_count": @"reboundsReceivedCount",
                                              @"created_at": @"creationDate" };
    
    return playerMappingDictionary;
}

+ (RKObjectMapping *)objectRequestMapping {
    RKObjectMapping *objectMapping = [RKObjectMapping requestMapping];
    [objectMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    
    return objectMapping;
}

+ (RKRequestDescriptor *)objectRequestDesctiptor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKObjectMapping *objectMapping = [self objectRequestMapping];
        RequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:objectMapping
                                                                  objectClass:[self class]
                                                                  rootKeyPath:nil];
    });
    
    
    return RequestDescriptor;
}

+ (RKObjectMapping *)objectResponseMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        EntityResponseMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class])
                                                    inManagedObjectStore:managedObjectStore];
        EntityResponseMapping.identificationAttributes = @[@"playerID"];
        [EntityResponseMapping addAttributeMappingsFromDictionary:[self objectMappingDictionary]];
    });
    
    return EntityResponseMapping;
}

+ (RKResponseDescriptor *)objectResponseDescriptorWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKEntityMapping *objectMapping = (RKEntityMapping *)[self objectResponseMappingWithManagedObjectStore:managedObjectStore];
        ResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
                                                                     pathPattern:nil
                                                                         keyPath:nil
                                                                     statusCodes:statusCodes];
    });
    
    
    return ResponseDescriptor;
}

@end
