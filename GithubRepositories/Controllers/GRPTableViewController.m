//
//  GRPTableViewController.m
//  GithubRepositories
//
//  Created by Jakmir on 6/21/16.
//  Copyright © 2016 Jakmir. All rights reserved.
//

#import "GRPTableViewController.h"
#import "GRPLeftAlignmentTableViewCell.h"
#import "GRPDataContext.h"
#import "GRPGithubRepositoryModel.h"
#import "GRPConstants.h"

static NSString * const kGRPNagivationItemTitle = @"Github Repositories";
static NSString * const kGRPLeftAlignCellIdentifier = @"LeftAlignCell";
static NSString * const kGRPRightAlignCellIdentifier = @"RightAlignCell";

@interface GRPTableViewController() <GRPModelObserver, GRPTableViewCellProtocol>

@property (nonatomic, strong) GRPDataContext *dataContext;
@property (nonatomic, strong) NSArray *items;

@end

@implementation GRPTableViewController

#pragma mark - 
#pragma mark - Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GRPLeftAlignmentTableViewCell" bundle:nil]
         forCellReuseIdentifier:kGRPLeftAlignCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"GRPRightAlignmentTableViewCell" bundle:nil]
         forCellReuseIdentifier:kGRPRightAlignCellIdentifier];
    
    [self.navigationItem setTitle:kGRPNagivationItemTitle];
    
    self.dataContext = [[GRPDataContext alloc] initWithURLString:kGRPRepositoryURL];
}

#pragma mark -
#pragma mark - Accessors and mutators

- (void)setDataContext:(GRPDataContext *)dataContext {
    if (_dataContext != dataContext) {
        [_dataContext cancel];
        [_dataContext unregisterObserver:self];
        _dataContext = dataContext;
        [_dataContext registerObserver:self];
        [_dataContext load];
    }
}

- (void)setItems:(NSArray *)items {
    if (_items != items) {
        _items = items;
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRPGithubRepositoryModel *model = self.items[indexPath.row];
    NSString *cellIdentifier = model.stargazersCount % 2 == 0 ? kGRPRightAlignCellIdentifier : kGRPLeftAlignCellIdentifier;
    GRPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell fillWithModel:model];
    return cell;
}

#pragma mark - 
#pragma mark - GRPModelObserver methods

- (void)modelDidLoad:(id)model {
    if ([model isKindOfClass:[GRPDataContext class]]) {
        GRPDataContext *context = (GRPDataContext *)model;
        self.items = context.items;
    }
}

- (void)modelDidFailToLoad:(id)model {
    if ([model isKindOfClass:[GRPDataContext class]]) {
        GRPDataContext *context = (GRPDataContext *)model;
        NSString *errorReason = context.errorReason;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:errorReason
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark -
#pragma mark - GRPTableViewCell delegate methods

- (void)tableViewCellButtonClicked:(id)sender {
    if ([sender isKindOfClass:[GRPTableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        GRPGithubRepositoryModel *model = self.items[indexPath.row];
        
        [[UIApplication sharedApplication] openURL:model.htmlUrl];
    }
}

@end
