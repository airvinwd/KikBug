//
//  KBHttpManager.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "KBBaseModel.h"

@implementation KBHttpManager

//+(AFHTTPResponseSerializer *)kb_serializer{
//    AFHTTPResponseSerializer *pt = [AFHTTPResponseSerializer serializer];
//    pt.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
//    return pt;
//}

+(void)sendGetHttpReqeustWithUrl:(NSString *)url Params:(NSDictionary *)param CallBack:(void (^)(id responseObject, NSError *err))block
{
    param = [KBHttpManager checkParam:param];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [KBHttpManager kb_serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager GET:url
      parameters:param
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
# if DEBUG
         NSLog(@"%@", responseObject);
# endif
//         NSinlineData * data = ( NSinlineData *)responseObject;
         block(responseObject,nil);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         block(nil,error);
     }];

}

+(void)sendPostHttpRequestWithUrl:(NSString *)url
                           Params:(NSDictionary *)param
                         CallBack:(void (^)(id, NSError *))block
{
//    param = [KBHttpManager checkParam:param];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [KBHttpManager kb_serializer];

//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFJSONRequestSerializer *jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    [manager setRequestSerializer:jsonRequestSerializer];
    [manager.requestSerializer setValue:@"aaa" forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"aaa" forHTTPHeaderField:@"APP_KEY"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
  
    
    [manager POST:url
      parameters:param
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
# if DEBUG
         NSLog(@"%@", responseObject);
         KBBaseModel *baseModel = [KBBaseModel mj_objectWithKeyValues:responseObject];
         NSDictionary *dataDic = [self dictionaryWithJsonString:baseModel.data];
# endif
         block(dataDic,nil);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         block(nil,error);
     }];

}

//check the app key param
+(NSDictionary*)checkParam:(NSDictionary*)param
{
    if(!param||![[param allKeys] containsObject:@"key"]){
        NSMutableDictionary* dic;
        if(param){
            dic = [NSMutableDictionary dictionaryWithDictionary:param];
        }else{
            dic = [NSMutableDictionary dictionary];
        }
        [dic setObject:APPKEY forKey:@"key"];
        param = [NSDictionary dictionaryWithDictionary:dic];
    }
    return  param;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



@end
