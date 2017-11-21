//
//  AKBoggleBoardItem.m
//  BoggleApp
//
//  Created by Atul Khatri on 21/11/17.
//  Copyright © 2017 Atul Khatri. All rights reserved.
//

#import "AKBoggleBoardItem.h"

@implementation AKBoggleBoardItem
-(instancetype)initWithString:(NSString*)string{
    self = [super init];
    if (self) {
        _string = [string lowercaseString];
        _visited = NO;
    }
    return self;
}
@end
