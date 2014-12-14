//
//  GPCityListController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/3/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GPCityListController.h"
#import "GPCitySection.h"
#import "GPCity.h"
#import "GPMetaDataTool.h"
#import "GPSearchResultController.h"
#import "GPCover.h"

#define kSearchH 44

@interface GPCityListController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSMutableArray *_citySections; // all city information
    GPCover *_cover;
    UITableView *_tableView;
    UISearchBar *_searchBar;
    GPSearchResultController *_searchResult;
}
@end

@implementation GPCityListController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1. add search box
    [self addSearchBar];
    
    // 2. add tableview
    [self addTableView];
    
    // 3. load data
    [self loadCitiesData];
}

#pragma mark add search bar
- (void)addSearchBar
{
    UISearchBar *search = [[UISearchBar alloc] init];
    search.delegate = self;
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchH);
    search.placeholder = @"Please enter city name or pinyin";
//    search.tintColor =
//    search.barStyle = 
    [self.view addSubview:search];
    _searchBar = search;
}

#pragma mark add table view
- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    CGFloat h = self.view.frame.size.height - kSearchH;
    tableView.frame = CGRectMake(0, kSearchH, self.view.frame.size.width, h);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark load cities data
- (void)loadCitiesData
{
    _citySections = [NSMutableArray array];
    NSArray *sections = [GPMetaDataTool sharedGPMetaDataTool].totalCitySections;
    [_citySections addObjectsFromArray:sections];
}

#pragma mark - search bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //MyLog(@"%@", searchText);
    
    if (searchText.length == 0) {
        // hide search view
        [_searchResult.view removeFromSuperview];
    } else {
        // display search view
        if (_searchResult == nil) {
            _searchResult = [[GPSearchResultController alloc] init];
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        [self.view addSubview:_searchResult.view];
        _searchResult.searchText = searchText;
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // display cancel button
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // display overlay
    if (_cover == nil) {
        _cover = [GPCover coverWithTarget:self action:@selector(coverClick)];
    }
    _cover.frame = _tableView.frame;
    [self.view addSubview:_cover];
    [UIView animateWithDuration:0.3 animations:^{
        [_cover reset];
    }];
}

#pragma mark observe clicking overlay
- (void)coverClick
{
    // 1. remove overlay
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    
    // 2. hide cancel button
    [_searchBar setShowsCancelButton:NO animated:YES];
    
    // 3. dismiss keyboard
    [_searchBar resignFirstResponder];
}

#pragma mark called when keyboard is dismissed
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self coverClick];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
    
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_citySections[section] cities].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    GPCitySection *citySection = _citySections[indexPath.section];
    GPCity *city = citySection.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    GPCitySection *citySection = _citySections[section];
    return citySection.name;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // retrieve all values for "name" property in _citySections
    return [_citySections valueForKeyPath:@"name"];
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPCitySection *s = _citySections[indexPath.section];
    GPCity *city = s.cities[indexPath.row];
    [GPMetaDataTool sharedGPMetaDataTool].currentCity = city;
    
    // send notifications
//    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil userInfo:@{kCityKey : city}];
}

@end











