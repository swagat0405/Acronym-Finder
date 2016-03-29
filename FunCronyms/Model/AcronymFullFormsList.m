//
//  AcronymFullFormsList.m
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import "AcronymFullFormsList.h"


@implementation AcronymFullFormsList

-(void)parseData{
    
    NSArray *tempArray=[self.vars copy];
    
    if (self.vars) {
        self.vars=[NSMutableArray arrayWithCapacity:1];
    }
    
    [self.vars removeAllObjects];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AcronymFullForm *acronym=[AcronymFullForm new];
        
        acronym.freq=[obj objectForKey:@"freq"];
        acronym.lf=[obj objectForKey:@"lf"];
        acronym.since=[obj objectForKey:@"since"];
        
        [self.vars addObject:acronym];
    }];
}

@end
