//
//  PL4WebImageSearchViewController.m
//  
//
//  Created by Nikolay Shubenkov on 30/05/15.
//
//

#import "PL4WebImageSearchViewController.h"

#import "PL4DataParser.h"

@interface PL4WebImageSearchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PL4WebImageSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSParameterAssert(self.searchImageName.length > 0);
    // Do any additional setup after loading the view.
    [self loadImage];
}

#pragma mark - Setup

- (void)loadImage
{
    NSString *url = @"https://ajax.googleapis.com/ajax/services/search/images";
    NSString *version = @"1.0";
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (CFStringRef)self.searchImageName,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8 ));
    
    NSString *searchAPIString = [NSString stringWithFormat:@"%@?q=%@&v=%@",url,encodedString,version];
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchAPIString]];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [self showImageFromJSON:jsonData];
    
}

- (void)showImageFromJSON:(NSDictionary *)json
{
    PL4DataParser *parser = [PL4DataParser new];
    NSString *imageURL = [parser imageURLFromDictionary:json];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    UIImage *image = [UIImage imageWithData:imageData];
    self.imageView.image = image;
    
}











@end
