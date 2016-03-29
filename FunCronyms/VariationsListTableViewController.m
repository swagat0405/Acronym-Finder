//
//  VariationsListTableViewController.m
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import "VariationsListTableViewController.h"
#import "AcronymFullForm.h"

@interface VariationsListTableViewController ()

@end

@implementation VariationsListTableViewController
@synthesize variationsListArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Variations";
    
    [self.tableView setAllowsSelection:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [variationsListArr count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return _originalFullFormStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"variationsCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    AcronymFullForm *fullForm = [variationsListArr objectAtIndex:indexPath.row];
    [cell.textLabel setText:[fullForm lf]];
    return cell;
}


@end
