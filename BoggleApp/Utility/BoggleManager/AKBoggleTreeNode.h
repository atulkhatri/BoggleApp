//
//  AKBoggleTreeNode.h
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKBoggleTreeNode : NSObject
@property (nonatomic, strong) NSMutableArray* childArray;
@property (nonatomic, assign) BOOL leafNode;
@end
