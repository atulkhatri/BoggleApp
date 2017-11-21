//
//  AKBoggleBoardItem.h
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKBoggleBoardItem : NSObject
-(instancetype)initWithString:(NSString*)string;
@property (nonatomic, strong) NSString* string;
@property (nonatomic, assign) BOOL visited;
@end
