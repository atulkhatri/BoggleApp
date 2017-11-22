//
//  AKHomeViewController.m
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import "AKHomeViewController.h"
#import "AKBoggleManager.h"

#define kSampleDimension 3
#define kSampleBoard @[@[@"y",@"o",@"x"],@[@"r",@"b",@"a"],@[@"v",@"e",@"d"]]
#define kSampleDictionary @[@"bred", @"yore", @"byre", @"abed", @"oread", @"bore", @"orby", @"robed", @"broad", @"byroad", @"robe", @"bored", @"derby", @"bade", @"aero", @"read", @"orbed", @"verb", @"aery", @"bead", @"bread", @"very", @"road", @"robbed", @"robber", @"board", @"dove", @"rob", @"ore", @"abe", @"bad"]
#define kMinimumWordLength 4

#define kCellReuseIdentifier @"HomeCell"

@interface AKHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* words;
@end

@implementation AKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.words = [[AKBoggleManager sharedInstance] findWordsInBoard:kSampleBoard ofDimension:kSampleDimension withDictionary:kSampleDictionary andMinimumWordLength:kMinimumWordLength];
    self.countLabel.text = [NSString stringWithFormat:@"%ld %@ FOUND!",self.words.count, (self.words.count==1)?@"WORD": @"WORDS"];
    if(self.words.count){
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource methods
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.\t%@",indexPath.row+1,[self.words objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.words.count;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
