//
//  KBMyTaskListViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/1/8.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBHttpManager.h"
#import "KBMyTaskListViewController.h"
#import "KBTaskCellTableViewCell.h"
#import "KBTaskDetailViewController.h"
#import "KBTaskListModel.h"
#import "KBTaskListManager.h"
#import "MJExtension.h"

@interface KBMyTaskListViewController () <UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSourceForMyTasks;
@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSourceForGroup;
@property (strong, nonatomic) NSDictionary* dataSourceDic;
@property (strong, nonatomic) UISegmentedControl* segmentedControl;
@property (strong, nonatomic) NSArray<KBTaskListModel*>* dataSource;
@end

@implementation KBMyTaskListViewController

static NSString* identifier = @"KBMyTaskListViewController";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"我的任务"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];

    self.dataSourceForGroup = [NSArray array];
    self.dataSourceForMyTasks = [NSArray array];
    self.dataSourceDic = @{ @(0) : self.dataSourceForMyTasks,
        @(1) : self.dataSourceForGroup };
    self.dataSource = [NSArray array];

    [self configSegmentControl];
    [self addObserver:self forKeyPath:@"self.segmentedControl.selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id>*)change context:(void*)context
{
    NSInteger newIndex = self.segmentedControl.selectedSegmentIndex;
    self.dataSource = self.dataSourceDic[@(newIndex)];
    [self.tableView reloadData];
}

- (void)loadData
{
    [self showLoadingView];
    WEAKSELF;
    [KBTaskListManager fetchMyTasksWithCompletion:^(NSArray<KBTaskListModel *> *model, NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hideLoadingView];
        if (model && !error) {
            weakSelf.dataSourceForGroup = model;
            weakSelf.dataSourceDic = @{ @(0) : weakSelf.dataSourceForGroup,
                @(1) : weakSelf.dataSourceForGroup };
            weakSelf.dataSource = weakSelf.dataSourceDic[@(weakSelf.segmentedControl.selectedSegmentIndex)];
            [weakSelf.tableView reloadData];

        } else {
            [weakSelf showLoadingViewWithText:@"网络错误，请重新刷新"];
        }
    }];
}

- (void)configSegmentControl
{
    NSArray* segmentedArray = [NSArray arrayWithObjects:@"我接受的", @"来自群组", nil];
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor whiteColor];
    [self.navigationItem setTitleView:segmentedControl];
    self.segmentedControl = segmentedControl;
}

- (void)configTableView
{
    [super configTableView];
    [self.tableView registerClass:[KBTaskCellTableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)configConstrains
{
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-BOTTOM_BAR_HEIGHT];
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
    KBTaskCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
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
    KBTaskDetailViewController* detailVC = (KBTaskDetailViewController*)[[HHRouter shared] matchController:TASK_DETAIL];
    [detailVC fillWithContent:self.dataSource[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [self hideLoadingView];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
