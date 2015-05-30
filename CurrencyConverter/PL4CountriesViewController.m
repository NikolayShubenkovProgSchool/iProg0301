//
//  PL4CountriesViewController.m
//  CurrencyConverter
//
//  Created by Nikolay Shubenkov on 30/05/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL4CountriesViewController.h"

#import "PL4WebImageSearchViewController.h"

#import "PL4CountryTableViewCell.h"
#import "PL4DataParser.h"
#import "PL4Country.h"

@interface PL4CountriesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PL4CountriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Setup

- (void)setup
{
    [self loadData];
    [self setupViews];
}

- (void)loadData
{
    if (self.countries.count > 0){
        return;
    }
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.freecurrencyconverterapi.com/api/v3/countries"]];
    NSError *error = nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                    options:0
                                                      error:&error];
    NSLog(@"%@",json);
    [self updateModelsWithNewData:json];
}

- (void)updateModelsWithNewData:(NSDictionary *)countriesJSON
{
    PL4DataParser *parser = [PL4DataParser new];
    self.countries = [parser parseCounrties:countriesJSON];
}

- (void)setupViews
{
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //запросим ячейку у tableView
    PL4CountryTableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"CountryCellIdentifier"];
    
    //настроить ячейку
    PL4Country *aCountry   = [self countryAtIndexPath:indexPath];
    
    [self configureCell:aCell withCountry:aCountry];
    
    return aCell;
}

- (void)configureCell:(PL4CountryTableViewCell *)aCell withCountry:(PL4Country *)country
{
    aCell.countryLabel.text  = country.name;
    aCell.currencyLabel.text = country.currencySymbol;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PL4Country *aCountry = [self countryAtIndexPath:indexPath];
    [self showCountryDetailes:aCountry];
}

- (void)showCountryDetailes:(PL4Country *)country
{
    [self performSegueWithIdentifier:@"ShowCountryImage" sender:country];
}

- (PL4Country *)countryAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger elementIndex = indexPath.row;
    PL4Country *aCountry   = self.countries[elementIndex];
    return aCountry;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowCountryImage"]){
        PL4WebImageSearchViewController *webController = [segue destinationViewController];
        PL4Country *aCountry = sender;
        webController.title = aCountry.name;
        webController.searchImageName = aCountry.name;
    }
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
