//
//  PL4Country.m
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL4Country.h"

@implementation PL4Country

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andKey:(NSString *)key
{
    self = [super init];
    if (self){
        _name = dictionary[@"name"];
        _currencyID = dictionary[@"currencyId"];
        _currencySymbol = dictionary[@"currencySymbol"];
    }
    return self;
}

@end
