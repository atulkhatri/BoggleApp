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

@interface AKHomeViewController ()

@end

@implementation AKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray* words = [[AKBoggleManager sharedInstance] findWordsInBoard:kSampleBoard ofDimension:kSampleDimension withDictionary:kSampleDictionary andMinimumWordLength:kMinimumWordLength];
    NSLog(@"Words: %@", words);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
