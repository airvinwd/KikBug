//
//  KBNavigator.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "FontasticIcons.h"
#import "KBGroupListViewController.h"
#import "KBLoginManager.h"
#import "KBLoginViewController.h"
#import "KBMyTaskListViewController.h"
#import "KBNavigator.h"
#import "KBTaskDetailViewController.h"
#import "KBTaskListTableViewController.h"
#import "KBUserHomeViewController.h"
#import "KBGroupSearchViewController.h"
#import "KBGroupDetailViewController.h"

@interface KBNavigator () <UITabBarControllerDelegate>
@property (nonatomic, strong) UITabBarController* tabBarController;

@property (nonatomic, strong) UINavigationController* presentNavController;
@end

@implementation KBNavigator

SINGLETON_IMPLEMENTION(KBNavigator, sharedNavigator);

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showViewController:(UIViewController*)viewController
{
    [self showViewController:viewController withShowType:KBUIManagerShowTypePush];
}

- (void)showViewController:(UIViewController*)viewController withShowType:(KBUIManagerShowType)showType
{
    switch (showType) {
    case KBUIManagerShowTypePush: {
        [[self currentNavigationController] pushViewController:viewController animated:YES];
    } break;
    case KBUIManagerShowTypePresent: {
        self.presentNavController = [self navControllerWithRoot:viewController];
        self.presentNavController.navigationBarHidden = YES;
        [self.tabBarController presentViewController:self.presentNavController
                                            animated:YES
                                          completion:NULL];

    } break;
    default:
        break;
    }
    
    
    
//    switch (showType) {
//        case TNUIManagerShowTypePush: //push
//        {
//            [[self currentNavigationController] pushViewController:viewController animated:YES];
//        }
//            break;
//        case TNUIManagerShowTypePresent: //modal
//        {
//            self.presentContainerNav = [self navControllerWithRoot:viewController];
//            self.presentContainerNav.navigationBarHidden = YES;
//            [self.tabBarController presentViewController:self.presentContainerNav
//                                                animated:YES
//                                              completion:NULL];
//        }
//            break;
//        case TNUIManagerShowTypeAddSubview: //addSub
//        {
//            UIViewController *topViewController = [[self currentNavigationController] topViewController];
//            [topViewController addChildViewController:viewController];
//            [topViewController.view addSubview:viewController.view];
//            [viewController.view setFrame:topViewController.view.frame];
//            [viewController didMoveToParentViewController:topViewController];
//        }
//            break;
//        default:
//            break;
//    }

}

#pragma mark - Utility

- (UINavigationController*)currentNavigationController
{
    return (UINavigationController*)[self.tabBarController selectedViewController];
}

- (KBViewController *)topViewController
{
    UIViewController *topViewController = [self currentNavigationController].topViewController;
    if (![topViewController isKindOfClass:[KBViewController class]])
    {
        return nil;
    }
    
    return (KBViewController *)topViewController;
}

- (UINavigationController*)navControllerWithRoot:(UIViewController*)controller
{
    NSParameterAssert(controller);
    UINavigationController* aNav = [[UINavigationController alloc] initWithRootViewController:controller];
    [KBNavigator setNavigationBarStyle:aNav];
    aNav.navigationBarHidden = YES;
    return aNav;
}

+ (void)setNavigationBarStyle:(UINavigationController *)aNav
{
    [aNav.navigationBar setBarTintColor:THEME_COLOR];
    [aNav.navigationBar setTintColor:[UIColor whiteColor]];
    [aNav.navigationBar setTitleTextAttributes:@{ NSFontAttributeName : APP_FONT(17),
                                                  NSForegroundColorAttributeName : [UIColor whiteColor] }];
    [aNav.navigationBar setTranslucent:NO];
}

- (void)showRootViewController
{
    [KBNavigator showLoginPage];
    UITabBarController* tb = [[UITabBarController alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    tb.delegate = self;
    tb.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController = tb;
    //Init tabbar controller
    KBTaskListTableViewController* listVC = [[KBTaskListTableViewController alloc] init];

    KBMyTaskListViewController* mytasklistVC = [[KBMyTaskListViewController alloc] init];
    mytasklistVC.title = @"我的任务";

    KBGroupListViewController* groupListVC = [[KBGroupListViewController alloc] init];
    [groupListVC setTitle:@"我的群组"];

    KBUserHomeViewController* userVC = [[KBUserHomeViewController alloc] init];
    userVC.title = @"个人中心";

    tb.viewControllers = @[ [self navControllerWithRoot:listVC],
        [self navControllerWithRoot:mytasklistVC],
        [self navControllerWithRoot:groupListVC],
        [self navControllerWithRoot:userVC] ];

    //    [tb.tabBar setTintColor:[UIColor whiteColor]];
    //    [tb.tabBar setBarTintColor:THEME_COLOR];

    self.tabBarController = tb;

    //    [self setTabbarImages];
    [self setIconForFirstTab];
}

#pragma mark - Set Image For Tabbar

- (void)setIconForFirstTab
{

    NSArray* imageNames = @[ @"TaskList_icon",
        @"UserCenter_icon",
        @"Group_icon",
        @"UserCenter_icon",
        @"UserCenter_icon" ];
    NSArray* selectedImageNames = @[ @"TaskList_icon",
        @"UserCenter_icon",
        @"Group_icon",
        @"UserCenter_icon",
        @"UserCenter_icon" ];

    [self.tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem* item, NSUInteger idx, BOOL* stop) {
        //        FIIcon *icon = [FIEntypoIcon iconWithName:imageNames[idx]];
        //        UIImage *image = [icon imageWithBounds:CGRectMake(0, 0, 20, 20) color:[UIColor grayColor]];
        UIImage* image = [UIImage imageNamed:imageNames[idx]];
        UIImage* scaledTabBarItem1Image = [UIImage imageWithCGImage:[image CGImage] scale:(image.scale) orientation:(image.imageOrientation)];
        //        FIIcon *iconSelected = [FIEntypoIcon iconWithName:selectedImageNames[idx]];
        //        UIImage *imageSelected = [iconSelected imageWithBounds:CGRectMake(0, 0, 20, 20) color:THEME_COLOR];
        UIImage* imageSelected = [UIImage imageNamed:selectedImageNames[idx]];
        imageSelected = [UIImage imageWithCGImage:[imageSelected CGImage] scale:(imageSelected.scale) orientation:(imageSelected.imageOrientation)];

        item.image = [scaledTabBarItem1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
}

#pragma mark -
#pragma mark - TabbarControllerDelegate

#pragma mark - Register Route
+ (void)registerLocalUrls
{
    [[HHRouter shared] map:LOGIN_PAGE_NAME toControllerClass:[KBLoginViewController class]];
    [[HHRouter shared] map:MY_TASK_PAGE_NAME toControllerClass:[KBMyTaskListViewController class]];
    [[HHRouter shared] map:GROUPR_PAGE_NAME toControllerClass:[KBGroupListViewController class]];
    [[HHRouter shared] map:TASK_DETAIL toControllerClass:[KBTaskDetailViewController class]];
    [[HHRouter shared] map:SEARCH_GROUP_PAGE_URL toControllerClass:[KBGroupSearchViewController class]];
    [[HHRouter shared] map:GROUP_DETAIL_PAGE toControllerClass:[KBGroupDetailViewController class]];
}


+ (void)showLoginPage {
    //    if ([KBLoginManager checkIfNeedLoginPage]) {
    if (YES) {
        KBLoginViewController *loginVC = (KBLoginViewController *)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
        [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
    }
}

@end
