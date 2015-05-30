//
//  PL4Country.h
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PL4Country : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *currencyID;
@property (nonatomic, strong) NSString *currencySymbol;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andKey:(NSString *)key;

@end
