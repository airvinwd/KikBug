//
//  KBGroupManager.h
//  KikBug
//
//  Created by DamonLiu on 16/3/5.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBBaseModel,KBGroupSearchModel,KBGroupDetailModel;
@interface KBGroupManager : NSObject

+ (void)joinGroupWithGroupId:(NSString*)groupId phrase:(NSString*)phrase block:(void (^)(KBBaseModel* baseMode, NSError* error))block;

+ (void)searchGroupWithKeyword:(NSString*)keyword block:(void (^)(KBGroupSearchModel* baseMode, NSError* error))block;

+ (void)fetchGroupDetailWithGroupId:(NSString*)groupId block:(void (^)(KBGroupDetailModel*, NSError*))block;

+ (void)fetchMyGroupsWithBlock:(void (^)(KBGroupSearchModel* baseMode, NSError* error))block;
@end
