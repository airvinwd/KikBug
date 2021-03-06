//
//  Macros.h
//  KikBug
//
//  Created by DamonLiu on 15/11/9.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBUIConstant.h"
#ifndef Macros_h
#define Macros_h

/***Model Definitions**/
#define JSONSTIRNG @property (copy, nonatomic, readwrite) NSString*
#define JSONINT @property (assign, nonatomic) NSInteger
#define JSONARRAY @property (strong, nonatomic) NSArray*
/***App Font Size ****/
#define APP_FONT_SIZE_MIDDLE 12
#define APP_FONT_SIZE_LARGE 14
#define APP_FONT_SIZE_SMALL 10

/*****Fonts*****/

#define APP_FONT_SMALL [UIFont systemFontOfSize:18]
#define APP_FONT_NORMAL [UIFont systemFontOfSize:20]
#define APP_FONT_LARGE [UIFont systemFontOfSize:22]

/****Font Attribute**/
#define SUBTITLE_ATTRIBUTE @{ NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor grayColor] }

#define TITLE_ATTRIBUTE @{ NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor] }

#define BUTTON_TITLE_ATTRIBUTE @{ NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor whiteColor] }

#define BUTTON_TITLE_NOTENABLED_ATTRIBUTE @{ NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor lightGrayColor] }
//获取屏幕 宽度、高度
#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

#define SCREEN_WIDTH (IsPortrait ? MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))

#define SCREEN_HEIGHT (IsPortrait ? MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))

//weak self

#define WEAKSELF __weak __typeof(&*self) weakSelf = self;
#define STRONGSELF __strong typeof(self) strongSelf = weakSelf;
#define NSSTRING_NOT_NIL(string) string ? string : @""
#define INT_TO_STIRNG(intvalue) [NSString stringWithFormat:@"%ld", (long)intvalue]

//load url from plist
#define HOST @"http://120.27.163.157:8008/kikbug-api"
#define GETURL(key) (NSString*)[[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"url" ofType:@"plist"]] objectForKey:key]
#define APPKEY (NSString*)[[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"property" ofType:@"plist"]] objectForKey:@"AppKey"]

//

/********************new url*********************/
#define GETURL_V2(key) [HOST stringByAppendingString:((NSString*)[[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"url2.0" ofType:@"plist"]] objectForKey:key])]
#define TIP_LOADING @"加载中..." //加载中...

#define UIManager [KBNavigator sharedNavigator]
#define CoreManager [CoreDataManager sharedManager]

//单例模式的宏
#define SINGLETON_INTERFACE(className, singletonName) +(className*)singletonName;

#define SINGLETON_IMPLEMENTION(className, singletonName)          \
                                                                  \
    static className* _##singletonName = nil;                     \
                                                                  \
    +(className*)singletonName                                    \
    {                                                             \
        static dispatch_once_t onceToken;                         \
        dispatch_once(&onceToken, ^{                              \
            _##singletonName = [[super allocWithZone:NULL] init]; \
        });                                                       \
        return _##singletonName;                                  \
    }                                                             \
                                                                  \
    +(id)allocWithZone : (struct _NSZone*)zone                    \
    {                                                             \
        return [self singletonName];                              \
    }                                                             \
                                                                  \
    +(id)copyWithZone : (struct _NSZone*)zone                     \
    {                                                             \
        return [self singletonName];                              \
    }

/************************************* Color ****************************************************/

#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
//#define THEME_COLOR RGB(80, 118, 156)
#define THEME_COLOR [KBUIConstant themeColor]
#define GRAY_COLOR [UIColor hexStringToColor:@"0xd4d4d4"]
#define LIGHT_GRAY_COLOR [UIColor colorWithHexNumber:0xe3e3e3]
#define HEXCOLOR(hexValue) [UIColor colorWithHexNumber:hexValue]
/************************************* Margin ****************************************************/
#define SMALL_MARGIN 5
#define MEDIUM_MARGIN 10
#define LARGE_MARGIN 15

#define APP_FONT(size) [UIFont systemFontOfSize:size]
#define TOP_TOOL_BAR_HEIGHT 64
#define BOTTOM_BAR_HEIGHT 49
#endif /* Macros_h */

/************************************* Login ****************************************************/
#define USER_STATUS @"USER_STATUS"
#define USER_ID @"UserId"
#define USER_PHONE @"Phone"
#define USER_EMAIL @"Email"
#define SESSION @"KikbugSession"

/************************************* Navigation Page Name ****************************************************/
#define LOGIN_PAGE_NAME @"/user/login"
#define MY_TASK_PAGE_NAME @"/user/tasklist"
#define GROUPR_PAGE_NAME @"/user/group"
#define TASK_DETAIL @"/taskDetail"
#define SEARCH_GROUP_PAGE_URL @"/SearchGroup"
#define GROUP_DETAIL_PAGE @"/GROUP_DETAIL_PAGE"
#define REGISTER_PAGE @"/registerpage"
#define REGISTER_PAGE_STEP_2 @"/confirmToken"
#define GROUP_TASKS @"/tasks/group"
#define MY_BUG_REPORT_LIST @"/bug/list"
#define MY_TASK_REPORT @"/task/report"
#define SIMPLE_EDITOR @"/editor"
#define ADD_BUG_STEP_1 @"/createBug/step1"
#define PROTOCOL_PAGE @"/register/protocol"
#define CREATE_REPORT_STEP_1 @"/report/new"

/*************************/
#define STORED_USER_ID [[NSUserDefaults standardUserDefaults] valueForKey:USER_ID]
#define STORED_USER_PHONE [[NSUserDefaults standardUserDefaults] valueForKey:USER_PHONE]
#define TRANSLATE(responseObject) KBErrorModel* errorModel = [KBErrorModel mj_objectWithKeyValues:responseObject];

/*************Delegate Check************/
#define DELEGATE_HAS_METHOD(delegateName, method) (self.delegate && self.delegate respondsToSelector \
                                                   : @selector(method))
