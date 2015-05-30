//
//  DPL4DataParser.m
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL4DataParser.h"

#import "PL4Country.h"

@implementation PL4DataParser

- (NSArray *)parseCounrties:(NSDictionary *)json
{
    NSMutableArray *countries = [NSMutableArray new];
    
    NSDictionary *results = json[@"results"];
    [results enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *countryDictionary, BOOL *stop) {
        
        PL4Country *aCountry = [[PL4Country alloc]initWithDictionary:countryDictionary
                                                              andKey:key];
        [countries addObject:aCountry];
    }];
    
    return [countries copy];
}

- (NSString *)imageURLFromDictionary:(NSDictionary *)dictionary
{
    NSLog(@"image data %@",dictionary);
    NSArray *results = dictionary[@"responseData"][@"results"];
    
    NSDictionary *firstResult = [results firstObject];
    NSString *url = firstResult[@"tbUrl"];
    
    NSParameterAssert(url.length > 0);
    
    return url;
}

@end
