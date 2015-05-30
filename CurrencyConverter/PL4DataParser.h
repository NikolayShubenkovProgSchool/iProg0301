//
//  DPL4DataParser.h
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PL4DataParser : NSObject

- (NSArray *)parseCounrties:(NSDictionary *)countries;
- (NSString *)imageURLFromDictionary:(NSDictionary *)dictionary;

@end
