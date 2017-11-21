//
//  AKBoggleTreeNode.m
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import "AKBoggleTreeNode.h"

#define kMaxChars 26

@implementation AKBoggleTreeNode
- (instancetype)init{
    self = [super init];
    if (self) {
        self.leafNode = NO;
        self.childArray = [[NSMutableArray alloc] initWithCapacity:kMaxChars];
        for(NSInteger i=0; i < kMaxChars; i++){
            [self.childArray addObject:[NSNull null]];
        }
    }
    return self;
}
@end
