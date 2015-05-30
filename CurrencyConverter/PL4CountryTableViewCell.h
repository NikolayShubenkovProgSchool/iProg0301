//
//  PL4CountryTableViewCell.h
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PL4CountryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

@end
