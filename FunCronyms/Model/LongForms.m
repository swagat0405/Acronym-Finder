//
//  LongForms.m
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import "LongForms.h"
#import "AcronymFullForm.h"


@implementation LongForms

-(void)parseData{
    
    NSMutableArray *tempArray=[self.lfsArray mutableCopy];
    if (!self.lfsArray) {
        self.lfsArray =[NSMutableArray arrayWithCapacity:1];
    }
    [self.lfsArray removeAllObjects];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AcronymFullFormsList *fullList=[[AcronymFullFormsList alloc]init];
        AcronymFullForm *acronym=[[AcronymFullForm alloc]init];
        
        acronym.freq=[obj objectForKey:@"freq"];
        acronym.lf=[obj objectForKey:@"lf"];
        acronym.since=[obj objectForKey:@"since"];
        
        fullList.acronymFullForm=acronym;
        fullList.vars=[NSMutableArray arrayWithArray:[obj objectForKey:@"vars"]];
        
        [fullList parseData];
        
        [self.lfsArray addObject:fullList];
    }];
}

@end
