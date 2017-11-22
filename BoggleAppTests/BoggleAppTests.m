//
//  BoggleAppTests.m
//  BoggleAppTests
//
//  Created by Atul Khatri on 22/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AKBoggleManager.h"

#define kSampleDimension 3
#define kSampleBoard @[@[@"y",@"o",@"x"],@[@"r",@"b",@"a"],@[@"v",@"e",@"d"]]
#define kSampleDictionary @[@"bred", @"yore", @"byre", @"abed", @"oread", @"bore", @"orby", @"robed", @"broad", @"byroad", @"robe", @"bored", @"derby", @"bade", @"aero", @"read", @"orbed", @"verb", @"aery", @"bead", @"bread", @"very", @"road", @"robbed", @"robber", @"board", @"dove", @"rob", @"ore", @"abe", @"bad"]

#define kResultWithMinLengthOf5 @[@"orbed",@"oread",@"robed",@"bored",@"bread",@"broad",@"byroad",@"derby"]

@interface BoggleAppTests : XCTestCase

@end

@implementation BoggleAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*!
 * @discussion This test checks the number of words found for a given Boggle board in dictionary.
 */
- (void)testNumberOfWordsFound {
    NSArray* words = [[AKBoggleManager sharedInstance] findWordsInBoard:kSampleBoard ofDimension:kSampleDimension withDictionary:kSampleDictionary andMinimumWordLength:4];
    XCTAssertTrue(words.count == 23);
}

/*!
 * @discussion This test checks for empty result array when minimum word length exceeds the longest word in dictionary.
 */
- (void)testNoWordsForLength{
    NSArray* words = [[AKBoggleManager sharedInstance] findWordsInBoard:kSampleBoard ofDimension:kSampleDimension withDictionary:kSampleDictionary andMinimumWordLength:8];
    XCTAssertTrue(words.count == 0);
}

/*!
 * @discussion This test validates the result with some pre-calculated set of result for its correctness.
 */
- (void)testWordsCorrectness{
    NSMutableArray* words = [[[AKBoggleManager sharedInstance] findWordsInBoard:kSampleBoard ofDimension:kSampleDimension withDictionary:kSampleDictionary andMinimumWordLength:5] mutableCopy];
    NSMutableIndexSet* indexSet = [NSMutableIndexSet new];
    for(NSString* word in words){
        for(NSString* result in kResultWithMinLengthOf5){
            if([word isEqualToString:result]){
                [indexSet addIndex:[words indexOfObject:word]];
            }
        }
    }
    [words removeObjectsAtIndexes:indexSet];
    XCTAssertTrue(words.count == 0);
}

/*!
 * @discussion This test validates the dimension of the board. If count of Boggle board rows and columns are not as per the required dimension. To make this test fail, please uncomment the code below.
 */
- (void)testBoardDimensionValidity{
    NSInteger requiredDimension = kSampleDimension;
    NSArray* boggleBoard = kSampleBoard;
    // Uncommend below line to make this test fail for invalid board
    //NSArray* boggleBoard = @[@[@"y",@"o",@"x"],@[@"r",@"b",@"a"],@[@"v",@"e",@"d",@"z"]];
    BOOL isBoardValid = YES;
    if(boggleBoard.count == requiredDimension){
        for(NSArray* row in boggleBoard){
            if(row.count != requiredDimension){
                isBoardValid = NO;
                break;
            }
        }
    }else{
        isBoardValid = NO;
    }
    XCTAssertTrue(isBoardValid);
}

@end
