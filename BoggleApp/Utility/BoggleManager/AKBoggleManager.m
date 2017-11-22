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
    self.boggleBoard = [self boggleBoardWithBoard:board];

    AKBoggleTreeNode* rootNode = [self treeWithDictionary:dictionary];
    
    for(NSMutableArray* rowArray in self.boggleBoard){
        for(AKBoggleBoardItem* item in rowArray){
            int ascii = [item.string characterAtIndex:0] - 'a';
            id childNode = [rootNode.childArray objectAtIndex:ascii];
            if([childNode isKindOfClass:[AKBoggleTreeNode class]]){
                [self findWordInBoard:self.boggleBoard withNode:childNode string:item.string row:[self.boggleBoard indexOfObject:rowArray] andColumn:[rowArray indexOfObject:item]];
            }
        }
    }
    return [self.wordsFound copy];
}

- (void)findWordInBoard:(NSArray*)board withNode:(AKBoggleTreeNode*)node string:(NSString*)string row:(NSInteger)row andColumn:(NSInteger)column{
    if(node.leafNode){
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
                    for (int c=-1; c<=1; c++) {
                        for (int r=-1; r<=1; r++) {
                            AKBoggleBoardItem* nextItem = [self boardItemForRow:(row + r) andColumn:(column + c)];
                            if(nextItem && [nextItem.string isEqualToString:itemString]){
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

- (AKBoggleBoardItem*)boardItemForRow:(NSInteger)row andColumn:(NSInteger)column{
    if(row >= 0 && row < self.dimension && column >= 0 && column < self.dimension){
        NSMutableArray* array = [self.boggleBoard objectAtIndex:row];
        return [array objectAtIndex:column];
    }
    return nil;
}

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

- (AKBoggleTreeNode*)treeWithDictionary:(NSArray*)dictionary{
    AKBoggleTreeNode* rootNode = [AKBoggleTreeNode new];
    for(NSString* word in dictionary){
        NSUInteger length = [word length];
        if(length < self.minWordLength){
            continue;
        }
        unichar buffer[length+1];
        [[word lowercaseString] getCharacters:buffer range:NSMakeRange(0, length)];
        AKBoggleTreeNode* currentNode = rootNode;
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
@end
