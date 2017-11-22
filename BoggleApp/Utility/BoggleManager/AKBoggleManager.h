//
//  AKBoggleManager.h
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 * @class AKBoggleManager
 * @discussion This class has the core logic of finding all the words for a given Boggle Board.
 */
@interface AKBoggleManager : NSObject
/*!
 * @discussion Returns a shared instance of AKBoggleManager
 * @return sharedInstance Shared instance of AKBoggleManager
 */
+ (instancetype)sharedInstance;

/*!
 * @discussion This method finds words in a given Boggle Board character array and a dictionary
 * @param board An array of array containing characters of Boggle board
 * @param dimension Dimention of the given Boggle board
 * @param dictionary An array of dictionary words
 * @param length Minimum length of the words required as a result
 * @warning Please make sure that the Board has valid dimensions as per dimensions provided in this method or else the program will crash with message.
 * @return Array of words found in given board
 */
- (NSArray*)findWordsInBoard:(NSArray*)board ofDimension:(NSInteger)dimension withDictionary:(NSArray*)dictionary andMinimumWordLength:(NSInteger)length;
@end
