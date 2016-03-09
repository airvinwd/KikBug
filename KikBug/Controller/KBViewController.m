//
//  KBViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/26.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBViewController.h"
#import "MBProgressHUD.h"

@interface KBViewController ()
@property (strong, nonatomic) MBProgressHUD* hud;
@end

@implementation KBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self configConstrains];
    [self loadData];
}

- (void)loadData
{
}

- (void)configConstrains
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Hud Methods

- (void)showLoadingView
{
    [self showLoadingViewWithText:TIP_LOADING];
}

- (void)showLoadingViewWithText:(NSString*)text
{
    if (!self.hud) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[self hubShowInView] animated:YES];
        if (text) {
            hud.labelText = text;
        }
        else {
            hud.labelText = @"加载中...";
        }

        hud.removeFromSuperViewOnHide = YES;
        self.hud = hud;
    }
    [self hubShowInView].userInteractionEnabled = NO;
}

- (void)hideLoadingView
{
    [self.hud hide:YES];
    [self hubShowInView].userInteractionEnabled = YES;
    self.hud = nil;
}

- (UIView*)hubShowInView
{
    //    UIView *inView;
    //    if (self.tableView) {
    //        inView = self.tableView;
    //    }
    //    else {
    //        inView = self.view;
    //    }
    return self.view;
}

@end
