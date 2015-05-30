//
//  PL4CurrencyExchangeVIewController.m
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL4CurrencyExchangeVIewController.h"

@interface PL4CurrencyExchangeVIewController ()

@property (weak, nonatomic) IBOutlet UITextField *fromCurrencyField;
@property (weak, nonatomic) IBOutlet UITextField *toCurrencyField;
@property (weak, nonatomic) IBOutlet UILabel *currencyExchangeResult;

@end


@implementation PL4CurrencyExchangeVIewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.fromCurrencyField.text = @"USD";
    self.toCurrencyField.text   = @"RUB";
    
    self.currencyExchangeResult.text = nil;
    
    //строки ниже не обязательны
    self.fromCurrencyField.textColor = [UIColor orangeColor];
    self.toCurrencyField.textColor   = [UIColor purpleColor];
    
    self.fromCurrencyField.placeholder = @"Из валюты";
    self.toCurrencyField.placeholder   = @"В валюту";
}

#pragma mark - UI Events

- (IBAction)showCurrencyExchangeRate:(UIButton *)sender
{
    //список стран с конвертацией
//http://www.freecurrencyconverterapi.com/api/v3/convert?q=USD_RUB&compact=ultra
    
    NSString *convertString = [self convertString];
    
    NSString *url = [NSString stringWithFormat:@"http://www.freecurrencyconverterapi.com/api/v3/convert?q=%@&compact=ultra",convertString];
    
    NSLog(@"url to request: %@",url);
    
    [self showCurrencyExchangeRateFromLink:url];
}

- (void)showCurrencyExchangeRateFromLink:(NSString *)courceLink
{
    //Скачаем данные по ссылке
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:courceLink]];
    
    //Преобразуем данные в объекты NSFoundation
    NSDictionary *courceInfo = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:nil];
    NSLog(@"%@",courceInfo);
    [courceInfo allKeys];
    [courceInfo allValues];
    
    NSNumber *courceValue = courceInfo[[self convertString]];
    //
    //записать в лейбл эту строку
    self.currencyExchangeResult.text = [courceValue stringValue];
}

- (NSString *)convertString
{
    NSString *fromCurrency = self.fromCurrencyField.text;
    NSString *toCurrency   = self.toCurrencyField.text;
    
    
    //   USD_RUB
    NSString *convertString = [NSString stringWithFormat:@"%@_%@",fromCurrency,toCurrency];
    NSLog(@"%@",convertString);
    
    return convertString;
}


@end


























