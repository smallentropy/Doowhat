//
//  DoowhatViewController.m
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import "DoowhatViewController.h"
#import "DoowhatDataModel.h"
#import "ToDoItem.h"
#import "ToDoItemCell.h"

#define kCellIdentifier @"ToDoCell"
#define kRowHeight  50.0f

@interface DoowhatViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DoowhatDataModel *model;

@end

@implementation DoowhatViewController

- (id)init {
    if (self = [super init]) {
        self.model = [[DoowhatDataModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView registerClass:[ToDoItemCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.view addSubview:self.tableView];
}

- (UIColor *)colorForIndex:(NSUInteger)index {
    float value = ((float)index / (float)self.model.count) * .6f;
    return [UIColor colorWithRed:1.0f green:value blue:0.0f alpha:1.0f];
}

#pragma mark - ToDoTableViewCellDelegate Methods
- (void)todoItemDeleted:(ToDoItem *)item {
    NSUInteger index = [self.model indexOfItem:item];
    [self.tableView beginUpdates];
    
    [self.model removeItemAtIndex:index];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoItem *item = [self.model itemAtIndex:indexPath.row];
    ToDoItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.delegate = self;
    cell.item = item; // Sets the strikethrough labels text
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

@end
