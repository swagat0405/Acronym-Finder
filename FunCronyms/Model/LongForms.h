//
//  LongForms.h
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AcronymFullFormsList.h"

@interface LongForms : NSObject

@property (nonatomic, strong) NSMutableArray *lfsArray; // obj of acronymfullformslist
@property (nonatomic, strong) NSString *sf;

-(void)parseData;
@end
