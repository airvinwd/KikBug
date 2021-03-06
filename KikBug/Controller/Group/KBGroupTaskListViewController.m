//
//  KBGroupTaskListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/3/23.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBGroupTaskListViewController.h"
#import "KBTaskListModel.h"
#import "KBTaskListManager.h"
#import "KBTaskCellTableViewCell.h"
#import "KBTaskDetailViewController.h"

@interface KBGroupTaskListViewController ()
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSource;
@end

@implementation KBGroupTaskListViewController

//static NSString* identifier = @"KBMyTaskListViewController";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"群组任务"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    
    //    self.dataSourceForMyTasks = [NSArray array];
    self.dataSource = [NSArray array];
}


- (void)loadData
{
    [self showLoadingView];
    WEAKSELF;
    [KBTaskListManager fetchTasksFromGroup:self.groupId WithCompletion:^(NSArray<KBTaskListModel *> *model, NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hideLoadingView];
        if (model && !error) {
            weakSelf.dataSource = model;
            if (model.count > 0) {
                [weakSelf removeEmptyView];
                [weakSelf.tableView reloadData];
            } else {
                [weakSelf showEmptyViewWithText:@"这个群组还没有发布任务"];
            }
//            [weakSelf.tableView reloadData];
        } else {
//            [weakSelf showLoadingViewWithText:@"网络错误，请重新刷新"];
            [weakSelf showErrorView];
        }
    }];
}

- (void)configTableView
{
    [super configTableView];
    [self.tableView registerClass:[KBTaskCellTableViewCell class] forCellReuseIdentifier:[KBTaskCellTableViewCell cellIdentifier]];
}

- (void)configConstrains
{
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero ];
}

#pragma mark - TableView Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBTaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[KBTaskCellTableViewCell cellIdentifier] forIndexPath:indexPath];
    if ([cell isKindOfClass:[KBTaskCellTableViewCell class]]) {
        [cell fillWithContent:self.dataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [KBTaskCellTableViewCell cellHeight];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UIViewController* detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC setParams:@{@"taskId":self.dataSource[indexPath.row].taskId}];
    [UIManager showViewController:detailVC withShowType:KBUIManagerShowTypePush];
    [self hideLoadingView];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - Memory Management
- (void)didReceiveMemoryWarning
{
    self.dataSource = nil;
}

- (void)setParams:(NSDictionary *)params
{
    self.groupId = [params valueForKey:@"groupId"];
}

@end
