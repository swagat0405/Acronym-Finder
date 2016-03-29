//
//  AcronymFullFormsList.h
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AcronymFullForm.h"

@interface AcronymFullFormsList : NSObject

@property (nonatomic, strong) AcronymFullForm *acronymFullForm;

@property (nonatomic, strong) NSMutableArray *vars;

-(void)parseData;
@end
