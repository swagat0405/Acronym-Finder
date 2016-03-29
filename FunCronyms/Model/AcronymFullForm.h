//
//  AcronymFullForm.h
//  FunCronyms
//
//  Created by Swagat Mishra on 3/28/16.
//  Copyright © 2016 Swagat Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymFullForm : NSObject

@property (nonatomic, strong) NSString *lf;
@property (nonatomic, strong) NSString *since;
@property (nonatomic, strong) NSString *freq;

- (instancetype)initWithParamsFromDict:(NSDictionary *)_dict;
@end
