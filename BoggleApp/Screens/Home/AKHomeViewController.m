//
//  AKHomeViewController.m
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import "AKHomeViewController.h"
#import "AKBoggleManager.h"

#define kSampleDimension 4
#define kSampleBoard @[@[@"a",@"b",@"c",@"d"],@[@"e",@"f",@"g",@"h"],@[@"i",@"j",@"k",@"l"],@[@"m",@"n",@"o",@"p"]]
#define kSampleDictionary @[@"aeh",@"abe",@"dab",@"gda",@"ifb",@"htp",@"ahe",@"dbg",@"afkp",@"kgfj",@"onjg"]

@interface AKHomeViewController ()

@end

@implementation AKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray* words = [[AKBoggleManager sharedInstance] findWordsInBoard:kSampleBoard ofDimension:kSampleDimension withDictionary:kSampleDictionary];
    NSLog(@"Words: %@", words);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
