//
//  AKBoggleManager.m
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import "AKBoggleManager.h"
#import "AKBoggleTreeNode.h"
#import "AKBoggleBoardItem.h"

#define kMaxChars 26

@interface AKBoggleManager()
@property (nonatomic, strong) NSArray* boggleBoard;
@property (nonatomic, strong) NSArray* dictionary;
@property (nonatomic, assign) NSInteger dimension;
@property (nonatomic, assign) NSInteger minWordLength;

@property (nonatomic, strong) NSMutableArray* wordsFound;
@end

@implementation AKBoggleManager
+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (NSArray*)findWordsInBoard:(NSArray*)board ofDimension:(NSInteger)dimension withDictionary:(NSArray*)dictionary andMinimumWordLength:(NSInteger)length{
    self.wordsFound = [NSMutableArray new];
    self.dimension = dimension;
    self.dictionary = dictionary;
    self.minWordLength = length;
    
    // Crash with message
    NSAssert([self areDimensionsValidForBoard:board], @"Incorrect Boggle board dimensions!");
    
    // Create an AKBoggleBoardItem based board with this board
    self.boggleBoard = [self boggleBoardWithBoard:board];

    // Create a tree with all the words in given dictionary
    AKBoggleTreeNode* rootNode = [self treeWithDictionary:dictionary];
    
    for(NSMutableArray* rowArray in self.boggleBoard){
        for(AKBoggleBoardItem* item in rowArray){
            // Traverse each item of the Boggle board and check if root node has any child node for the character of the boggle board item
            int ascii = [item.string characterAtIndex:0] - 'a';
            id childNode = [rootNode.childArray objectAtIndex:ascii];
            if([childNode isKindOfClass:[AKBoggleTreeNode class]]){
                // If child exists for this character, call this method by passing the child node as the start node
                [self findWordInBoard:self.boggleBoard withNode:childNode string:item.string row:[self.boggleBoard indexOfObject:rowArray] andColumn:[rowArray indexOfObject:item]];
            }
        }
    }
    return [self.wordsFound copy];
}

/*!
 * @discussion This method is a recursive method which finds a character in adjacent cells of the Boggle board and if this character is found in any of the child nodes of the tree, it recursively finds characters in child node.
 * @param board A pre-processed Boggle board with AKBoggleBoardItems
 * @param node The node of the tree to check if the child nodes contain the adjacent characters
 * @param string The resulting string matched so far
 * @param row Current row of the Boggle board to search
 * @param column Current column of the Boggle board to search
 */
- (void)findWordInBoard:(NSArray*)board withNode:(AKBoggleTreeNode*)node string:(NSString*)string row:(NSInteger)row andColumn:(NSInteger)column{
    if(node.leafNode){
        // If node is a leaf node, add the resulting string in array
        [self.wordsFound addObject:string];
    }
    if(row >= 0 && row < self.dimension && column >= 0 && column < self.dimension){
        AKBoggleBoardItem* item = [self boardItemForRow:row andColumn:column];
        if(item && !item.visited){
            item.visited = YES;
            for(id childNode in node.childArray){
                if([childNode isKindOfClass:[AKBoggleTreeNode class]]){
                    int childIndex = (int)[node.childArray indexOfObject:childNode];
                    NSString* itemString = [NSString stringWithFormat:@"%c",childIndex+'a'];
                    // Traverse each adjacent Board item to see if
                    for (int c=-1; c<=1; c++) {
                        for (int r=-1; r<=1; r++) {
                            AKBoggleBoardItem* nextItem = [self boardItemForRow:(row + r) andColumn:(column + c)];
                            if(nextItem && [nextItem.string isEqualToString:itemString]){
                                // If child node exists for the character in nextItem, call this method recursively by passing the child node as the start node
                                [self findWordInBoard:board withNode:childNode string:[NSString stringWithFormat:@"%@%@",string,itemString] row:(row + r) andColumn:(column + c)];
                            }
                        }
                    }
                }
            }
            item.visited = NO;
        }
    }
}

#pragma mark - Helper methods
/*!
 * @discussion Checks if dimensions of the Boggle board are valid as per the input dimensions
 * @param board Boggle board to check
 * @return Returns true if dimensions are correct
 */
- (BOOL)areDimensionsValidForBoard:(NSArray*)board{
    BOOL isBoardValid = YES;
    if(board.count == self.dimension){
        for(NSArray* row in board){
            if(row.count != self.dimension){
                isBoardValid = NO;
                break;
            }
        }
    }else{
        isBoardValid = NO;
    }
    return isBoardValid;
}

/*!
 * @discussion This method returns a board item for a given Row & Column index in Boggle board
 * @param row Row integer represents the required row
 * @param column Column integer represents the specific column in the row
 * @return Boggle board item at a given row & column in Boggle board
 */
- (AKBoggleBoardItem*)boardItemForRow:(NSInteger)row andColumn:(NSInteger)column{
    if(row >= 0 && row < self.dimension && column >= 0 && column < self.dimension){
        NSMutableArray* array = [self.boggleBoard objectAtIndex:row];
        return [array objectAtIndex:column];
    }
    return nil;
}

/*!
 * @discussion Converts a string based Boggle board to an object oriented boggle board having all items as an instance of AKBoggleBoardItem so that the item can be marked as visited
 * @param board Input string based boggle board
 * @return An object based Boggle Board
 */
- (NSArray*)boggleBoardWithBoard:(NSArray*)board{
    NSMutableArray* boardArray = [NSMutableArray new];
    for(NSArray* array in board){
        NSMutableArray* row = [NSMutableArray new];
        for(NSString* string in array){
            [row addObject:[[AKBoggleBoardItem alloc] initWithString:string]];
        }
        [boardArray addObject:row];
    }
    return [boardArray copy];
}

/*!
 * @discussion Creates a tree from all the words of given dictionary
 * @param dictionary Array of words as a dictionary
 * @return Root of the tree made through all the words of dictionary
 */
- (AKBoggleTreeNode*)treeWithDictionary:(NSArray*)dictionary{
    AKBoggleTreeNode* rootNode = [AKBoggleTreeNode new];
    // Traverse each word in word dictionary
    for(NSString* word in dictionary){
        NSUInteger length = [word length];
        if(length < self.minWordLength){
            continue;
        }
        unichar buffer[length+1];
        [[word lowercaseString] getCharacters:buffer range:NSMakeRange(0, length)];
        AKBoggleTreeNode* currentNode = rootNode;
        // Traverse each character in this word and create a tree by setting the child on the proper ascii code index
        for(int i = 0; i < length; i++) {
            int index = buffer[i] - 'a';
            if([[currentNode.childArray objectAtIndex:index] isEqual:[NSNull null]]){
                [currentNode.childArray replaceObjectAtIndex:index withObject:[AKBoggleTreeNode new]];
            }
            currentNode = [currentNode.childArray objectAtIndex:index];
        }
        currentNode.leafNode = YES;
    }
    return rootNode;
}

#pragma mark -
@end
