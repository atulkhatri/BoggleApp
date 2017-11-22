//
//  AKBoggleTreeNode.h
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 * @class AKBoggleTreeNode
 * @discussion This class represents a node of a tree used to create a Tree from a dictionary of words.
 */
@interface AKBoggleTreeNode : NSObject
/*!
 * @brief Child array is a 26 element array representing each character in ascii code form.
 */
@property (nonatomic, strong) NSMutableArray* childArray;
/*!
 * @brief Leaf node is true if this node is the leaf node of the tree.
 */
@property (nonatomic, assign) BOOL leafNode;
@end
