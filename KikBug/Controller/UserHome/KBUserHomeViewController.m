//
//  KBUserHomeViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "KBUserHomeViewController.h"

@interface KBUserHomeViewController ()

@end

@implementation KBUserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"个人中心";
    if ([self checkIfNeedLoginPage]) {
        UIViewController *loginVC = [[HHRouter shared] matchController:@"/user/login"];
        [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
    } else {
        
    }
}

- (BOOL)checkIfNeedLoginPage {
    BOOL userLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_STATUS] boolValue];
    return !userLogin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
