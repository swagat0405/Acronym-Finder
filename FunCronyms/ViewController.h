//
//  ViewController.h
//  FunCronyms
//
//  Created by Swagat Mishra on 3/27/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *acronymTextField;
- (IBAction)findAcronymFullForm:(id)sender;

@end

