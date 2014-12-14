//
//  GPSearchResultController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPSearchResultController.h"
#import "GPMetaDataTool.h"
#import "GPCity.h"
#import "PinYin4Objc.h"

@interface GPSearchResultController ()
{
    NSMutableArray *_resultCities; // store all result cities
}
@end

@implementation GPSearchResultController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _resultCities = [NSMutableArray array];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    [_resultCities removeAllObjects];
    
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    fmt.vCharType = VCharTypeWithUUnicode;
    
    //MyLog(@"%@", pinyin);
    
    NSDictionary *cities = [GPMetaDataTool sharedGPMetaDataTool].totalCities;
    //MyLog(@"%@", cities);
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, GPCity *obj, BOOL *stop) {
        
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinInitial = [NSMutableString string];
        for (NSString *word in words) {
            [pinyinInitial appendString:[word substringToIndex:1]];
        }
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // 
        if ([obj.name rangeOfString:searchText].length != 0 || [pinyin rangeOfString:searchText.uppercaseString].length != 0 || [pinyinInitial rangeOfString:searchText.uppercaseString].length != 0)
        {
            [_resultCities addObject:obj];
        }
    }];
    
    // refresh table
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    GPCity *city = _resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d Results", _resultCities.count];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPCity *city = _resultCities[indexPath.row];
    [GPMetaDataTool sharedGPMetaDataTool].currentCity = city;
}

@end




