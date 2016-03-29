//
//  ViewController.m
//  FunCronyms
//
//  Created by Swagat Mishra on 3/27/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AcronymFullFormsTableViewController.h"
#import "LongForms.h"

@interface ViewController () <UITextFieldDelegate>

@end

static NSString *const baseURL = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.acronymTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.acronymTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.acronymTextField.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.acronymTextField resignFirstResponder];
}

- (IBAction)findAcronymFullForm:(id)sender {
    
    [self.acronymTextField resignFirstResponder];
    if ([self.acronymTextField.text isEqualToString:@""]) {
        
        //No Acronym is entered to search.
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter an Acronym to look up for full forms." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        //Look up full forms for the entered acronym
        [self fetchDetailsForAcronym];
    }
}

- (void)fetchDetailsForAcronym {
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.center = self.view.center;
    [progressHUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    //Create the request URL string
    NSString *requestURLStr = [NSString stringWithFormat:@"%@?sf=%@&if=nil",baseURL, self.acronymTextField.text];
    requestURLStr = [requestURLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    __block __weak UITextField *blockTextField = self.acronymTextField;
    
    //Request full forms via GET request.
    [manager GET:requestURLStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        if ([responseObject count]==0) {
            
            //No full forms found for entered acronym.
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No Full Forms Found for the entered Acronym. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                blockTextField.text = @"";
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [progressHUD hide:YES];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
            NSArray *responseArray=[[NSArray alloc] initWithArray:responseObject];
            NSMutableArray *finalFullFormsListArr = [NSMutableArray arrayWithCapacity:1];
            for (id obj in responseArray) {
                
                LongForms *longObj=[LongForms new];
                longObj.lfsArray=[NSMutableArray arrayWithArray:[obj objectForKey:@"lfs"]];
                longObj.sf=[obj objectForKey:@"sf"];
                [longObj parseData];
                [finalFullFormsListArr addObject:longObj];
            }
            
            [progressHUD hide:YES];
            
            //Prepare segue to display list of full forms.
            [self performSegueWithIdentifier:@"showAcronymFullFormsSegue" sender:finalFullFormsListArr];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        //Fetch full forms for acronym - service failure.
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error!!!" message:[NSString stringWithFormat:@"Look Up failed with error: %@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [progressHUD hide:YES];
        blockTextField.text = @"";
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

#pragma mark -
#pragma mark Textfield delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self fetchDetailsForAcronym];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [textField becomeFirstResponder];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier]isEqualToString:@"showAcronymFullFormsSegue"]) {
        
        AcronymFullFormsTableViewController *destinationViewController = (AcronymFullFormsTableViewController *)[segue destinationViewController];
        destinationViewController.fullFormsListArray=[NSArray arrayWithArray:sender];
        [destinationViewController setInputAcronymStr:self.acronymTextField.text];
    }
}

@end


