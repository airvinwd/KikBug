//
//  KBUserInfoModel.m
//  KikBug
//
//  Created by DamonLiu on 16/3/29.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBUserInfoModel.h"

@implementation KBUserInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userId":@"id",
             @"account":@"userName"};
}
@end
