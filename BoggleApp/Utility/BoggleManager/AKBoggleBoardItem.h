//
//  AKBoggleBoardItem.h
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 * @class AKBoggleBoardItem
 * @discussion This class represents a Boggle board item present in a Boggle Board.
 */
@interface AKBoggleBoardItem : NSObject
/*!
 * @discussion Custom initializer to set string of Board item
 * @param string String present in a Boggle board item
 * @return instanceType Instance of AKBoggleBoardItem
 */
-(instancetype)initWithString:(NSString*)string;
/*!
 * @brief String present in each Boggle board item.
 */
@property (nonatomic, strong) NSString* string;
/*!
 * @brief Visited is true if this item has been traversed once for finding a single word.
 */
@property (nonatomic, assign) BOOL visited;
@end
