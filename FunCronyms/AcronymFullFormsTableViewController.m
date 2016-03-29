//
//  AcronymFullFormsTableViewController.m
//  FunCronyms
//
//  Created by Swagat Mishra on 3/27/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import "AcronymFullFormsTableViewController.h"
#import "VariationsListTableViewController.h"
#import "LongForms.h"
#import "AcronymFullFormsList.h"

@interface AcronymFullFormsTableViewController () 

@end

@implementation AcronymFullFormsTableViewController
@synthesize fullFormsListArray;
@synthesize inputAcronymStr;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = inputAcronymStr;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return fullFormsListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    LongForms *obj=[fullFormsListArray objectAtIndex:section];
    return obj.lfsArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AcronymsFullFormsCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    LongForms *longFormObj = (LongForms *)[fullFormsListArray objectAtIndex:indexPath.section];
    AcronymFullFormsList *fullFormsListObj = (AcronymFullFormsList *)[[longFormObj lfsArray]objectAtIndex:indexPath.row];
    cell.textLabel.text = [[fullFormsListObj acronymFullForm]lf];
    
    NSInteger variationCount = [[fullFormsListObj vars]count];
    if (variationCount>=1) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)variationCount]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    LongForms *longFormObj = (LongForms *)[fullFormsListArray objectAtIndex:indexPath.section];
    AcronymFullFormsList *fullFormsListObj = (AcronymFullFormsList *)[[longFormObj lfsArray]objectAtIndex:indexPath.row];
    
    inputAcronymStr = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;

    [self performSegueWithIdentifier:@"showVariationsListSegue" sender:[fullFormsListObj vars]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier]isEqualToString:@"showVariationsListSegue"]) {
        VariationsListTableViewController *variationsController = [segue destinationViewController];
        [variationsController setOriginalFullFormStr:inputAcronymStr];
        [variationsController setVariationsListArr:sender];
    }
}


@end
