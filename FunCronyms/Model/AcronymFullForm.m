//
//  AcronymFullForm.m
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import "AcronymFullForm.h"

@implementation AcronymFullForm

@synthesize freq, lf, since;

- (instancetype)initWithParamsFromDict:(NSDictionary *)_dict {
    
    if (self = [super init]) {
        self.freq = [NSString stringWithFormat:@"%@",_dict[@"freq"]];
        self.lf = [NSString stringWithFormat:@"%@",_dict[@"lf"]];
        self.since = [NSString stringWithFormat:@"%@",_dict[@"since"]];
    }
    return self;
}

@end
